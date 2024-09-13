import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../utils/storage_util.dart';

class HomeController extends GetxController {
  // Variável para controle da visualização
  var currentViewIndex = 0.obs;
  Timer? _locationUpdateTimer;
  final ApiService _apiService = ApiService();
  final Rx<LatLng> currentPosition = Rx<LatLng>(const LatLng(0.0, 0.0));
  final Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  final RxBool isOnline = false.obs;
  final RxString userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserName();
    _loadUserId();
    _loadDriverStatus();
    getCurrentLocation();
    _startLocationUpdates();
  }

  @override
  void onClose() {
    super.onClose();
    _locationUpdateTimer?.cancel(); // Cancelar o timer ao fechar o controller
  }

  Future<void> _updateLocation() async {
    try {
      final userId = await StorageUtil.getUserId();
      if (userId != null) {
        await _apiService.updateDriverLocation(
          userId,
          currentPosition.value.latitude,
          currentPosition.value.longitude,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao atualizar localização: $e');
      }
    }
  }

  void _startLocationUpdates() {
    _locationUpdateTimer = Timer.periodic(Duration(minutes: 1), (timer) async {
      await getCurrentLocation(); // Atualizar a localização atual
      await _updateLocation(); // Enviar a localização para o backend
    });
  }

  // Sicronizar status
  Future<void> _loadDriverStatus() async {
    try {
      final userId = await StorageUtil.getUserId();
      if (userId != null) {
        final status = await _apiService.getDriverStatus(userId);
        isOnline.value = status;
      }
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao carregar o status');
    }
  }

  // Método para alternar entre visualizações
  void switchView(int index) {
    currentViewIndex.value = index;
  }

  Future<void> _loadUserId() async {
    final userId = await StorageUtil.getUserId();
    if (userId != null) {
      // Use o userId conforme necessário
    }
  }

  // Carregar o nome do usuário
  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('user_full_name') ?? 'Usuário';
  }

  // Obter a localização atual
  Future<void> getCurrentLocation() async {
    try {
      // Verifica se o serviço de localização está ativado
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Serviço de localização desativado.');
      }

      // Verifica permissões
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          throw Exception('Permissão de localização negada.');
        }
      }

      // Obtém a localização atual
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
        ),
      );

      // Atualiza a posição no estado
      currentPosition.value = LatLng(position.latitude, position.longitude);

      // Move a câmera do mapa para a localização atual
      if (mapController.value != null) {
        mapController.value!.animateCamera(
          CameraUpdate.newLatLng(currentPosition.value),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao obter a localização: $e');
      }
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController.value = controller;
  }

  // Método para alternar o status online/offline
  Future<void> toggleOnlineStatus() async {
    try {
      final userId = await StorageUtil.getUserId();
      if (userId != null) {
        await _apiService.toggleDriverStatus(userId, !isOnline.value);
        isOnline.value = !isOnline.value;
        // Mostrar uma mensagem de confirmação
        Get.snackbar(
          'Status Atualizado',
          isOnline.value ? 'Você está online' : 'Você está offline',
        );
      } else {
        Get.snackbar('Erro', 'Usuário não encontrado.');
      }
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao alternar o status');
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _apiService.logout();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Falha ao realizar logout. Tente novamente mais tarde.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

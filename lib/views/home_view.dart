import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Obx(() => Text(_homeController.userName.value)),
              accountEmail: const Text(''),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Obx(() => Text(
                      _homeController.userName.value.isNotEmpty
                          ? _homeController.userName.value[0]
                          : '',
                      style: const TextStyle(fontSize: 40.0),
                    )),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () async {
                try {
                  await _homeController.logout();
                  Get.offAllNamed('/login');
                } catch (e) {
                  Get.snackbar(
                    'Erro',
                    'Falha ao realizar logout. Tente novamente mais tarde.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: Obx(() {
        // Recarregar o mapa com a nova posição
        if (_homeController.mapController.value != null) {
          _homeController.mapController.value!.animateCamera(
            CameraUpdate.newLatLng(_homeController.currentPosition.value),
          );
        }

        return Stack(
          children: [
            // Usar IndexedStack para alternar
            IndexedStack(
              index: _homeController.currentViewIndex.value,
              children: [
                // Exibição do Mapa
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _homeController.currentPosition.value,
                    zoom: 14.0,
                  ),
                  onMapCreated: _homeController.onMapCreated,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                ),
                // Exibição do Histórico de Corridas
                //RideHistoryView(),
              ],
            ),
            // Botão de localizar o usuário no mapa (somente quando o mapa estiver visível)
            if (_homeController.currentViewIndex.value == 0)
              Positioned(
                bottom: 150, // Ajusta a posição acima da barra inferior
                right: 16,
                child: FloatingActionButton(
                  heroTag: 'location_button', // Tag única
                  onPressed: _homeController.getCurrentLocation,
                  child: const Icon(Icons.my_location),
                ),
              ),
            // Barra inferior personalizada com três botões
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, -2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Botão Mapa com ícone e cor condicional
                    Obx(() {
                      final isSelected =
                          _homeController.currentViewIndex.value == 0;
                      return TextButton(
                        onPressed: () {
                          _homeController.switchView(0);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.map,
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.black, // Cor do ícone
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Mapa',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.black, // Cor do texto
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    // Botão Online/Offline (botão do meio com borda diferenciada)
                    Obx(() => ElevatedButton.icon(
                          onPressed: () {
                            _homeController.toggleOnlineStatus();
                          },
                          icon: Icon(_homeController.isOnline.value
                              ? Icons.wifi_off
                              : Icons.wifi),
                          label: Text(_homeController.isOnline.value
                              ? 'Offline'
                              : 'Online'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _homeController.isOnline.value
                                ? Colors.red
                                : Colors.green,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(
                                color: _homeController.isOnline.value
                                    ? Colors.redAccent
                                    : Colors.greenAccent,
                                width: 2,
                              ),
                            ),
                          ),
                        )),
                    // Botão Corridas (Histórico de Corridas)
                    Obx(() {
                      final isSelected =
                          _homeController.currentViewIndex.value == 1;
                      return TextButton(
                        onPressed: () {
                          _homeController.switchView(1);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.history,
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.black, // Cor do ícone
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Corridas',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.black, // Cor do texto
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

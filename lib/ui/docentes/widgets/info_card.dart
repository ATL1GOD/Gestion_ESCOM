import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/docentes/model/docente_model.dart';

class DocenteInfoCard extends StatelessWidget {
  final HorarioModel horario;
  final DocenteModel docente;
  const DocenteInfoCard({
    super.key,
    required this.horario,
    required this.docente,
  });

  @override
  Widget build(BuildContext context) {
    // 1. El contenedor principal de la tarjeta (de _ProfileInfoCard)
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // La tarjeta se ajusta al contenido
        children: [
          // Espacio superior para que el avatar flote
          const SizedBox(height: 50),

          // 2. Contenido de _UserInfoSection
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    horario.profesor,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFf76c6c), // Rojo/Naranja
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      docente.ubicacion,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                docente.correo,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // 3. Contenido de _UserStats (incluyendo la lógica de _StatItem)
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // StatItem 1
              Column(
                children: [
                  Text(
                    '235',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Attention',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              // StatItem 2
              Column(
                children: [
                  Text(
                    '68',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Follow',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              // StatItem 3
              Column(
                children: [
                  Text(
                    '540',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Following',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 25),

          // 4. Contenido de _CreditBanner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFa7aedb), Color(0xFF8e97c7)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text(
                  'Transparent credit: A1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

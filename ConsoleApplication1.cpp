#include <iostream>
using namespace std;

extern "C" void AVX512Test(double* c, double* a, double* b);
extern "C" bool AVXFoundationDetection();

void main() {
    
    if (AVXFoundationDetection()) {
        std::cout << "This CPU is capable of ZVX512 Fondation instructions." << std::endl;
        // Crear arrays para la prueba
        double a[8] = { 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 };
        double b[8] = { 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0 };
        double c[8] = { 0 };

        AVX512Test(c, a, b);  // Llamar la función de ensamblador

        // Mostrar el resultado
        std::cout << "Resultado de la suma: ";
        for (int i = 0; i < 8; ++i) {
            std::cout << c[i] << " ";
        }
        std::cout << std::endl;
    }
    else {
        std::cout << "Nope" << std::endl;
    }
}
#include <iostream>
#include <string>
#include <vector>
#include <cmath>
using namespace std;

extern "C" void MatrizxVector(float* matriz, float* vector, float* resultado);
extern "C" void Escalamiento(float* escalaX, float* escalaY, float* escalaZ, float* matrizAcumuladora);
extern "C" void Traslacion(float* traslacionX, float* traslacionY, float* traslacionZ, float* matrizAcumuladora);
extern "C" void Rotacion(float* sin_angle, float* cos_angle, int* eje, float* matrix);

int preguntarTransformacion() {
    //variables
    string transformacion;
    string entrada;
    vector<float> vectorInicial = { 0, 0, 0, 1 }; //el ultimo 1 es el w
    float angulo;
    vector<float> matrizAcumuladora = { // Matriz identidad 4x4 como un solo vector
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1
    };
    vector<float> resultado = { 0, 0, 0, 0 };

    cout << "Bienvenido a la calculadora matricial. Por favor, ingrese el vector a transformar." << endl;

    //pedir el vector inicial
    cout << "X: ";
    getline(cin, entrada);
    vectorInicial[0] = stof(entrada); //stof convierte de string a float
    cout << "Y: ";
    getline(cin, entrada);
    vectorInicial[1] = stof(entrada);
    cout << "Z: ";
    getline(cin, entrada);
    vectorInicial[2] = stof(entrada);

    //pedir las transformaciones
    cout << "Ingrese la transformacion que quiera realizar. Para composiciones, ingrese multiples numeros." << endl;
    cout << "[1] Traslacion\n[2] Rotacion\n[3] Escalamiento" << endl;
    getline(std::cin, transformacion);

    //recorrer la entrada para ver si es una composición
    for (size_t i = 0; i < transformacion.length(); i++) {
        if (transformacion[i] == '1') {
            // Traslación
            float traslacionX, traslacionY, traslacionZ;

            // Pedir valores de traslación
            cout << "Ingrese la traslacion en X: ";
            getline(cin, entrada);
            traslacionX = stof(entrada);

            cout << "Ingrese la traslacion en Y: ";
            getline(cin, entrada);
            traslacionY = stof(entrada);

            cout << "Ingrese la traslacion en Z: ";
            getline(cin, entrada);
            traslacionZ = stof(entrada);

            // Llamar a la función ensambladora para aplicar la traslación a la matriz acumuladora
            Traslacion(&traslacionX, &traslacionY, &traslacionZ, matrizAcumuladora.data());
        }
        else if (transformacion[i] == '2') {

            // Angulo en grados.
            float angulo_grados = 0.0f;
            cout << "Ingrese el angulo de la rotacion: ";
            getline(cin, entrada);
            angulo_grados = stof(entrada);

            // Convertir angulo a radianes
            float angulo_rad = angulo_grados * 3.14159265359f / 180.0f;  // Use 3.14 for Pi

            // Calcular seno y coseno del angulo
            float sin_angulo = sin(angulo_rad);
            float cos_angulo = cos(angulo_rad);

            int eje = -1;
            cout << "Ingrese el eje de la rotacion: ";
            getline(cin, entrada);
            if (entrada == "X" || entrada == "x") {
                eje = 0;
            }
            else if (entrada == "Y" || entrada == "y") {
                eje = 1;
            }
            else if (entrada == "Z" || entrada == "z") {
                eje = 2;
            }
            else {
                cout << "Error: ingrese un eje valido." << endl;
                return 1;
            }

            // Llamar funcion en ensablador para formar matriz de rotacion.
            Rotacion(&sin_angulo, &cos_angulo, &eje, matrizAcumuladora.data());
        }
        else if (transformacion[i] == '3') {
            // Escalamiento
            float escalaX, escalaY, escalaZ;

            // Se piden los datos a escalar
            cout << "Ingrese la escala en X: ";
            getline(cin, entrada);
            escalaX = stof(entrada);

            cout << "Ingrese la escala en Y: ";
            getline(cin, entrada);
            escalaY = stof(entrada);

            cout << "Ingrese la escala en Z: ";
            getline(cin, entrada);
            escalaZ = stof(entrada);

            // Llamar a la función ensambladora para aplicar la escala directamente a la matriz acumuladora
            Escalamiento(&escalaX, &escalaY, &escalaZ, matrizAcumuladora.data());
        }
        else {
            cout << "Error: ingrese una tranformacion valida." << endl;
            return 1;
        }
    }

    //Sacar el vector resultado de la matriz acumulada
    MatrizxVector(matrizAcumuladora.data(), vectorInicial.data(), resultado.data());

    // Imprimir resultado
    cout << "Vector transformado:" << endl;
    cout << "(" << resultado[0] << ", " << resultado[1] << ", " << resultado[2] << ")" << endl;

    return 0;
}

int main() {

    bool repetir = true;
    string entrada;

    while (repetir) {
        try {
            preguntarTransformacion();

            cout << "Desea hacer otro calculo?\n[S] Si\n[N] No" << endl;
            getline(std::cin, entrada);
            if (entrada == "N" || entrada == "n") {
                repetir = false;
            }
        }
        catch (const exception& e) {
            cerr << "Error, ha ingresado un dato inválido. Intente de nuevo." << endl;
        }
    }
    return 0;
}

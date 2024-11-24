#include <iostream>
#include <string>
#include <vector>
using namespace std;

extern "C" void MatrizxVector(float* matriz, float* vector, float* resultado);
extern "C" void Escalamiento(float* escalaX, float* escalaY, float* escalaZ, float* matrizAcumuladora);

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

    //recorrer la entrada para ver si es una composicion
    for (size_t i = 0; i < transformacion.length(); i++) {
        if (transformacion[i] == '1') {
            //traslacion
            //TO-DO
        }
        else if (transformacion[i] == '2') {
            //rotacion

            cout << "Ingrese el angulo de la rotacion: ";
            getline(cin, entrada);
            angulo = stof(entrada);

            cout << "Ingrese el eje de la rotacion: ";
            getline(cin, entrada);
            if (entrada == "X" || entrada == "x") {
                //ejeX
                //TO-DO
            }
            else if (entrada == "Y" || entrada == "y") {
                //eyeY
                //TO-DO
            }
            else if (entrada == "Z" || entrada == "z") {
                //ejeZ
                //TO-DO
            }
            else {
                cout << "Error: ingrese un eje valido." << endl;
                return 1;
            }
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

        preguntarTransformacion();

        cout << "Desea hacer otro calculo?\n[S] Si\n[N] No" << endl;
        getline(std::cin, entrada);
        if (entrada == "N" || entrada == "n") {
            repetir = false;
        }
    }

    return 0;
}

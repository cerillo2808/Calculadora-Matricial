# Calculadora Matricial

## Descripción
La **Calculadora Matricial** es una herramienta que permite realizar transformaciones geométricas en vectores tridimensionales utilizando matrices de transformación. Soporta las siguientes operaciones:

- **Traslación**: Desplazar un vector en el espacio 3D.
- **Rotación**: Rotar un vector alrededor de los ejes X, Y o Z.
- **Escalamiento**: Modificar la escala del vector en cada eje.
- **Composición de dos transformaciones** : Puede combinar dos transformaciones.

Este proyecto combina programación en C++ con ensamblador para optimizar las operaciones matemáticas.

---

## Características principales
- Soporte para composiciones de transformaciones (ejecutar múltiples operaciones en secuencia).
- Matriz acumuladora para gestionar las transformaciones aplicadas.
- Integración con funciones de ensamblador para optimización.
- Interfaz de consola intuitiva para ingresar datos.

---

## Requisitos
### Software
- **Visual Studio (community)**.
- **Compilador C++ compatible**: GCC, MSVC, o Clang.
- **MASM**: para compilar el código ensamblador.

### Dependencias
Ninguna dependencia externa. Todo el código es autónomo.

---

## Compilación y ejecución
1. Navegar al directorio deseado y clonar el repositorio:
   ```bash
   git clone https://github.com/cerillo2808/Calculadora-Matricial.git
   cd Calculadora-Matricial
2. Abrir Visual Studio Community.
3. Crear un nuevo proyecto en VS Community.
4. Hacer click derecho sobre el nombre del nuevo proyecto, seleccionar la opción de Dependencia de compilación > Personalizaciones de compilación > MASM.
5. Agregar archivos de código fuente a carpeta de proyecto nuevo.
6. Compilar con botón de compilación en VS Community.
7. Ejecutar con botón de ejecución en VS Community.
8. Ingresar datos según lo pida el programa y lo desee el usuario.

## Integrantes de equipo de trabajo
- Aarón Arce Alfaro / C30601
- Andy Cen Wu / C31939
- Juliana Rodríguez Mora / C36747
- Liqing Yosery Zheng Lu / C38680


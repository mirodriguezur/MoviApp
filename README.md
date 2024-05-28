# MovieApp

MovieApp es una aplicación iOS escrita en Swift que permite a los usuarios listar/buscar películas, y filtrarlas por categorías; para ello consume el API https://developers.themoviedb.org.

La aplicación está construida utilizando el framework UIKit y emplea tanto Storyboards como Xibs. Además, se sigue la arquitectura VIPER para una mejor separación de responsabilidades y una mayor escalabilidad del código.

## Características
- Listar películas: La aplicación muestra una lista de películas populares y mejor valoradas.
- Filtrar por categorías: Los usuarios pueden filtrar las películas por idioma, clasificación para adultos, y puntuaciones.
- Buscar películas: Los usuarios pueden buscar películas por título.
- Visualizar Detalles de cada película.

## Estructura VIPER

La arquitectura VIPER divide el código en cinco componentes principales:

- View: La interfaz de usuario y la lógica de presentación.
- Interactor: Mediador entre el Presenter y los datos.
- Presenter: Se encarga de actualizar la vista según los datos que llegan del Interactor.
- Entity: Modelos de datos utilizados en la aplicación.
- Router: Maneja la navegación entre vistas.

Para explicar la estructura VIPER de la app MovieApp, observe el diagrama a continuación que ilustra el módulo raíz o vista principal de la aplicación.

![VIPER](https://github.com/mirodriguezur/MoviApp/assets/66835869/39fd1d8b-4b0d-42c6-96f5-3c8ea50b8950)

### Descripción del Módulo RootMovie
RootMovieViewController es la vista principal que contiene un SegmentedControl para alternar entre películas populares y mejor valoradas. Además, cuenta con dos botones: uno para buscar películas y otro para filtrar películas por categoría. Cada uno de estos elementos visuales responde a la interacción del usuario. La responsabilidad de RootMovieViewController es mostrar la información adecuada y notificar al RootMoviePresenter sobre cualquier interacción o evento generado por el usuario.

![Screenshot 2024-05-27 at 10 10 48 PM](https://github.com/mirodriguezur/MoviApp/assets/66835869/c662fb35-e84a-46bd-92e5-11320b4298a5)

### Flujo de Trabajo en VIPER
1. Vista (RootMovieViewController)
   - Muestra las películas y proporciona la interfaz de usuario con un SegmentedControl y dos botones (Buscar y Filtrar).
   - Informa al RootMoviePresenter sobre las interacciones del usuario, como cambios en el SegmentedControl o toques en los botones.
2. Presentador (RootMoviePresenter)
   - Toma la información de la vista y determina la acción correspondiente.
   - Si el usuario interactúa con el SegmentedControl, el presentador solicita al RootMovieInteractor que cargue las películas adecuadas desde la API.
   - Si el usuario presiona los botones de Buscar o Filtrar, el presentador instruye al RootMovieRouter para navegar a los módulos correspondientes (FilterMovie o SearchMovie).
3. Interactor (RootMovieInteractor)
   - Se encarga de la lógica de negocio, como la carga de películas desde los endpoints de la API.
   - Utiliza un URLClient para conectarse a la red y recuperar el listado de películas.
   - Mapea el JSON recibido del servidor a una estructura de datos manejable (GeneralMovieEntity).
4. Router (RootMovieRouter)
   - Maneja la navegación entre diferentes módulos.
   - Al recibir instrucciones del presentador, navega a los módulos de búsqueda o filtrado de películas.
### Ejemplo de flujo
1. Cambio en SegmentedControl:
   - El usuario cambia el SegmentedControl para ver películas populares o mejor valoradas.
   - RootMovieViewController notifica al RootMoviePresenter sobre el cambio.
   - RootMoviePresenter solicita al RootMovieInteractor que cargue las películas correspondientes desde la API.
   - RootMovieInteractor obtiene los datos, los procesa y devuelve una lista de GeneralMovieEntity al presentador.
   - RootMoviePresenter actualiza la vista con las nuevas películas.
2. Botones de Filtrar y Buscar:
   - El usuario presiona el botón de Filtrar.
   - RootMovieViewController notifica al RootMoviePresenter.
   - RootMoviePresenter instruye al RootMovieRouter para navegar al módulo de filtrado (FilterMovie).
   - De manera similar, al presionar el botón de Buscar, se navega al módulo de búsqueda (SearchMovie).
     
Este flujo asegura una clara separación de responsabilidades y facilita la escalabilidad y mantenibilidad del código, siguiendo los principios de la arquitectura VIPER.

## Pruebas unitarias

El proyecto cuenta con algunos tests unitarios. Dado que cada módulo VIPER sigue una estructura similar, las pruebas unitarias tienden a ser parecidas entre sí. Por esta razón, se han construido solo algunas pruebas representativas para garantizar la funcionalidad básica y la integridad del código.

## Instalación y uso
1. Clona el repositorio
   > git clone https://github.com/mirodriguezur/MoviApp.git
2. Navega al directorio del proyecto
   > cd MovieApp 
3. Abre el proyecto en Xcode
   > open MovieApp.xcodeproj
4. El proyecto tiene una dependencia en [Kingfisher 7.11.0](https://github.com/onevcat/Kingfisher) debido a que facilita un renderizado sencillo de imágenes. Package Manager debería poder instalarlo sin ningún problema, pero en caso de que no funcione, por favor, vuelve a cargar esta dependencia a través de Switch Package Manager.
5. La API utilizada en este proyecto requiere una clave apiKey para acceder a los datos proporcionados por los endpoints. El proyecto actualmente utiliza una apiKey personal, la cual se encuentra ubicada en el archivo URLSessionHTTPClient. Si no se está obteniendo información de la API, una posible solución es registrarse en [The Movie Database (TMDb) API](https://developers.themoviedb.org) para obtener una nueva apiKey. Luego, reemplace la clave existente con la nueva clave obtenida.

## DEMO
![MovieAPP](https://github.com/mirodriguezur/MoviApp/assets/66835869/00fa84d1-83dd-433a-b991-9fa2949008ce)


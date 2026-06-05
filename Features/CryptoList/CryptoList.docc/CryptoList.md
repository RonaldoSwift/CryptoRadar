# ``CryptoList``

Pantalla encargada de mostrar el listado de criptomonedas con búsqueda, actualización y manejo de estados.

## Overview

CryptoList permite visualizar las criptomonedas obtenidas desde un servicio remoto.

Características principales:

- Lista de criptomonedas
- Búsqueda por nombre
- Pull to refresh
- Manejo de carga y errores
- Arquitectura basada en MVVM + Repository

## Topics

### Views

- ``CryptoListView``

### View Models

- ``CryptoListViewModel``

### Repository

- ``CryptoListRepositoryProtocol``
- ``CryptoListRepositoryImpl``

### Services

- ``CryptoServiceProtocol``
- ``AuthServiceCryptoList``

### Models

- ``CryptoResponse``

# 🚀 CryptoRadar

CryptoRadar es una aplicación iOS desarrollada en SwiftUI que permite visualizar el mercado de criptomonedas utilizando la API pública de CoinGecko.
La aplicación permite explorar criptomonedas, consultar información detallada, guardar favoritos y acceder mediante Deep Links.
---

# 📱 Funcionalidades

- Login y Registro de usuario
- Listado de criptomonedas
- Detalle de cada criptomoneda
- Agregar y eliminar favoritos
- Persistencia local mediante SwiftData
- Manejo de Keychain para autenticación
- Deep Links
- Arquitectura modular
- Inyección de dependencias mediante Swinject
---

# 📸 Screenshots

### Login

<div style="display: flex; gap: 10px;">
    <img src="Screenshots/login.png" alt="Login dark" width="45%">
    <img src="Screenshots/login-light.png" alt="Login light" width="45%">
</div>

### Register

<div style="display: flex; gap: 10px;">
    <img src="Screenshots/register.png" alt="Register dark" width="45%">
    <img src="Screenshots/register-light.png" alt="Register light" width="45%">
</div>

### Market

<div style="display: flex; gap: 10px;">
    <img src="Screenshots/market.png" alt="Market dark" width="45%">
    <img src="Screenshots/list-light.png" alt="Market light" width="45%">
</div>

### Crypto Detail

<div style="display: flex; gap: 10px;">
    <img src="Screenshots/detail.png" alt="Crypto detail dark" width="45%">
    <img src="Screenshots/detalle-light.png" alt="Crypto detail light" width="45%">
</div>

### Favorites

<div style="display: flex; gap: 10px;">
    <img src="Screenshots/favorites.png" alt="Favorites dark" width="45%">
    <img src="Screenshots/favorite-light.png" alt="Favorites light" width="45%">
</div>

### Settings

<div style="display: flex; gap: 10px;">
    <img src="Screenshots/settings.png" alt="Settings dark" width="45%">
    <img src="Screenshots/config-dark.png" alt="Settings light" width="45%">
</div>

---

# 🏗 Arquitectura

El proyecto está construido siguiendo una arquitectura MVVM modular.
Cada funcionalidad está separada en módulos independientes utilizando Swift Package Manager.
La navegación se encuentra centralizada desde la aplicación principal.

Se utiliza:
- MVVM
- Dependency Injection (Swinject)
- Repository Pattern
- Networking desacoplado
- SwiftData para persistencia local
---

# 📂 Estructura del proyecto

```text
CryptoRadar
│
├── Features
│   ├── Login
│   ├── Register
│   ├── CryptoList
│   ├── CryptoDetail
│   ├── Favorite
│   └── Settings
│
├── Shared
│   ├── StorageKit
│   ├── NetworkKit
│   └── ImageKit
│
└── CryptoRadar
    ├── Sources
    ├── Resources
    └── Core
```

---

# 🔗 Deep Links

Actualmente la aplicación soporta dos accesos directos:

- Abrir detalle de Bitcoin: `cryptoradar://crypto/bitcoin`
- Abrir favoritos: `cryptoradar://favorites`

Si el usuario no ha iniciado sesión, el Deep Link queda pendiente y se ejecuta automáticamente después del Login.

### QR de ejemplo

El código QR del enlace `cryptoradar://crypto/bitcoin` es:

<img src="Screenshots/qr-bitcoin.png" alt="QR CryptoRadar Bitcoin" width="220">

### QR de favoritos

<img src="Screenshots/qr-favorites.png" alt="QR CryptoRadar Favoritos" width="220">

> La aplicación debe estar instalada en el iPhone antes de escanear el QR.
> Escanea cualquiera de estos códigos con la cámara para abrir el deep link.

### Prueba manual en iPhone

1. Instala y abre la aplicación al menos una vez desde Xcode en el iPhone.
2. Escanea uno de los QR con la cámara del iPhone.
3. Pulsa la notificación para abrir CryptoRadar.
4. Verifica que la app se abre en la pantalla correcta.
5. Repite la prueba con `cryptoradar://crypto/bitcoin` y `cryptoradar://favorites`.

---

# 🛠 Stack Tecnológico

- Swift 6
- SwiftUI
- MVVM
- Swift Package Manager
- SwiftData
- Swinject
- URLSession
- CoinGecko API
- Keychain
- Deep Linking
---

# ⚙ Instalación

1. Clonar el repositorio
git clone:   https://github.com/RonaldoSwift/CryptoRadar.git
2. Abrir el proyecto en Xcode
3. Ejecutar la aplicación
---

# � Acceso de prueba

Para probar el login rápidamente, utiliza la cuenta demo de ReqRes:

- Correo: `eve.holt@reqres.in`
- Contraseña: `cityslicka`

Estas credenciales fueron verificadas contra el endpoint de login configurado en la aplicación.

---

# �👨‍💻 Autor

Ronaldo Vargas
Ingeniería de Sistemas
iOS Developer


# Grocery App Server

Ein produktionsbereiter REST-API-Server, entwickelt mit **Vapor 4** und **Swift 6**, der die Backend-Infrastruktur für die GroceryApp iOS-Anwendung bereitstellt. Dieser Server demonstriert moderne serverseitige Swift-Entwicklung mit PostgreSQL, JWT-Authentifizierung und umfassendem API-Design.

[🇺🇸 English Version](README.md)

## 🔗 Verwandte Repositories

- **iOS Client App**: [GroceryApp](https://github.com/tyfnnn/GroceryApp)
- **Geteilte DTOs**: [GroceryAppSharedDTO](https://github.com/tyfnnn/GroceryAppSharedDTO)

## 🚀 Features

### 🔐 Authentifizierung & Sicherheit
- **JWT-Authentifizierung** mit sicherer Token-Generierung und -Validierung
- **Passwort-Hashing** mit bcrypt für sichere Anmeldedatenspeicherung
- **Benutzerregistrierung und -anmeldung** mit umfassender Validierung
- **Token-basierte Autorisierung** für geschützte Endpunkte

### 📊 Datenbankverwaltung
- **PostgreSQL**-Integration mit Fluent ORM
- **Datenbankmigrationen** für versionskontrolliertes Schema-Management
- **Relationale Datenmodellierung** mit ordnungsgemäßen Fremdschlüssel-Constraints
- **Kaskadierungsoperationen** für Datenintegrität

### 🛠️ API-Endpunkte
- **RESTful Design** nach Industriestandards
- **CRUD-Operationen** für Benutzer, Lebensmittelkategorien und Artikel
- **Hierarchische Datenstruktur** (Benutzer → Kategorien → Artikel)
- **Umfassende Fehlerbehandlung** mit ordnungsgemäßen HTTP-Statuscodes

### 🏗️ Moderne Architektur
- **Async/await**-Unterstützung in der gesamten Anwendung
- **Typsichere Datenbankoperationen** mit Fluent
- **Modulares Controller-Design** für wartbaren Code
- **Geteilte DTOs** für konsistente Datenverträge

## 📋 API-Dokumentation

### Authentifizierungs-Endpunkte

#### Benutzer registrieren
```http
POST /api/register
Content-Type: application/json

{
  "username": "string",
  "password": "string"
}
```

#### Benutzer anmelden
```http
POST /api/login
Content-Type: application/json

{
  "username": "string", 
  "password": "string"
}
```

### Lebensmittelkategorie-Endpunkte

#### Kategorien abrufen
```http
GET /api/users/{userId}/grocery-categories
Authorization: Bearer {jwt_token}
```

#### Kategorie erstellen
```http
POST /api/users/{userId}/grocery-categories
Content-Type: application/json
Authorization: Bearer {jwt_token}

{
  "title": "string",
  "colorCode": "string"
}
```

#### Kategorie löschen
```http
DELETE /api/users/{userId}/grocery-categories/{categoryId}
Authorization: Bearer {jwt_token}
```

### Lebensmittelartikel-Endpunkte

#### Artikel nach Kategorie abrufen
```http
GET /api/users/{userId}/grocery-categories/{categoryId}/grocery-items
Authorization: Bearer {jwt_token}
```

#### Artikel erstellen
```http
POST /api/users/{userId}/grocery-categories/{categoryId}/grocery-items
Content-Type: application/json
Authorization: Bearer {jwt_token}

{
  "title": "string",
  "price": 0.0,
  "quantity": 0
}
```

#### Artikel löschen
```http
DELETE /api/users/{userId}/grocery-categories/{categoryId}/grocery-items/{itemId}
Authorization: Bearer {jwt_token}
```

## 🛠️ Installation & Setup

### Voraussetzungen
- **Swift 6.0+**
- **PostgreSQL 12+**
- **Vapor Toolbox** (empfohlen)

### Datenbank-Setup
1. PostgreSQL installieren und starten:
   ```bash
   # macOS mit Homebrew
   brew install postgresql
   brew services start postgresql
   
   # Datenbank erstellen
   createdb grocerydb
   ```

2. PostgreSQL-Benutzer erstellen (optional):
   ```sql
   CREATE USER ihr_benutzername WITH PASSWORD 'ihr_passwort';
   GRANT ALL PRIVILEGES ON DATABASE grocerydb TO ihr_benutzername;
   ```

### Server-Setup
1. Repository klonen:
   ```bash
   git clone https://github.com/tyfnnn/grocery-app-server.git
   cd grocery-app-server
   ```

2. Datenbankverbindung in `Sources/grocery-app-server/configure.swift` konfigurieren:
   ```swift
   let postgresConfig = SQLPostgresConfiguration(
       hostname: "localhost",
       username: "ihr_benutzername",  // Ersetzen Sie mit Ihrem Benutzernamen
       password: "ihr_passwort",      // Ersetzen Sie mit Ihrem Passwort
       database: "grocerydb",
       tls: .prefer(try .init(configuration: .clientDefault))
   )
   ```

3. Projekt erstellen:
   ```bash
   swift build
   ```

4. Datenbankmigrationen ausführen:
   ```bash
   swift run grocery-app-server migrate
   ```

5. Server starten:
   ```bash
   swift run
   ```

Der Server startet auf `http://localhost:8080`

### Docker-Setup (Alternative)

Sie können den Server auch mit Docker ausführen:

```bash
# Image erstellen
docker compose build

# Server starten
docker compose up app
```

## 🗄️ Datenbankschema

### Benutzer-Tabelle
- `id` (UUID, Primärschlüssel)
- `username` (String, Eindeutig)
- `password` (String, Gehashed)

### Lebensmittelkategorien-Tabelle
- `id` (UUID, Primärschlüssel)
- `title` (String)
- `color_code` (String)
- `user_id` (UUID, Fremdschlüssel → Benutzer)

### Lebensmittelartikel-Tabelle
- `id` (UUID, Primärschlüssel)
- `title` (String)
- `price` (Double)
- `quantity` (Integer)
- `grocery_category_id` (UUID, Fremdschlüssel → Lebensmittelkategorien)

## 🧪 Testen

Test-Suite ausführen:
```bash
swift test
```

### Test-Abdeckung
- Authentifizierungsablauf-Tests
- API-Endpunkt-Validierung
- Datenbankoperations-Tests
- Fehlerbehandlungs-Verifizierung

## 🚀 Deployment

### Produktionskonfiguration
1. Umgebungsvariablen setzen:
   ```bash
   export LOG_LEVEL=info
   export DATABASE_URL=postgresql://user:pass@host:port/dbname
   export JWT_SECRET=ihr-sicherer-geheimer-schluessel
   ```

2. Für Produktion erstellen:
   ```bash
   swift build -c release
   ```

3. Mit Produktionseinstellungen ausführen:
   ```bash
   .build/release/grocery-app-server serve --hostname 0.0.0.0 --port 8080
   ```

### Docker-Deployment
Das enthaltene `Dockerfile` bietet einen produktionsbereiten Container:
- Mehrstufiger Build für optimierte Image-Größe
- Sicherheits-Best-Practices mit Nicht-Root-Benutzer
- Statisches Linking für bessere Performance

## 🏗️ Architektur-Details

### Projektstruktur
```
Sources/
├── grocery-app-server/
│   ├── Controllers/          # API-Routen-Handler
│   ├── Models/              # Datenbankmodelle
│   ├── Migrations/          # Datenbank-Schema-Migrationen
│   ├── Extensions/          # DTO-Erweiterungen für Vapor
│   ├── configure.swift      # App-Konfiguration
│   ├── entrypoint.swift     # Anwendungs-Einstiegspunkt
│   └── routes.swift         # Basis-Routen-Definitionen
```

### Hauptkomponenten

#### Modelle
- **User**: Benutzerkonto-Management mit Authentifizierung
- **GroceryCategory**: Benutzerspezifische Lebensmittelkategorien
- **GroceryItem**: Artikel innerhalb von Kategorien
- **AuthPayload**: JWT-Token-Payload-Struktur

#### Controller
- **UserController**: Registrierung und Authentifizierung
- **GroceryController**: CRUD-Operationen für Kategorien und Artikel

#### Sicherheitsfeatures
- Passwort-Hashing mit bcrypt
- JWT-Token-Generierung und -Validierung
- Geschützte Routen mit Authentifizierungs-Middleware
- Eingabevalidierung und -bereinigung

## 🔧 Konfiguration

### Umgebungsvariablen
- `LOG_LEVEL`: Logging-Ausführlichkeit (debug, info, warning, error)
- `DATABASE_URL`: PostgreSQL-Verbindungsstring
- `JWT_SECRET`: Geheimer Schlüssel für JWT-Signierung (in Produktion ändern!)

### Datenbankkonfiguration
Der Server verwendet Fluent ORM mit PostgreSQL. Verbindungseinstellungen können in `configure.swift` geändert werden.

## 🤝 Beitragen

1. Repository forken
2. Feature-Branch erstellen
3. Ihre Änderungen vornehmen
4. Tests für neue Funktionalität hinzufügen
5. Sicherstellen, dass alle Tests bestehen
6. Pull Request einreichen

## 📚 Lernressourcen

Dieser Server demonstriert:
- **Moderne Swift Server-Entwicklung** mit Vapor 4
- **Datenbankdesign** mit ordnungsgemäßer Normalisierung und Beziehungen
- **RESTful API-Design** nach Best Practices
- **Authentifizierung & Autorisierung** mit JWT
- **Test-Strategien** für serverseitige Anwendungen
- **Deployment-Praktiken** mit Docker und Produktionskonfigurationen

## 📄 Lizenz

Dieses Projekt ist für Bildungszwecke verfügbar. Siehe LICENSE-Datei für Details.

---

💧 Erstellt mit [Vapor](https://vapor.codes) - Ein serverseitiges Swift Web-Framework

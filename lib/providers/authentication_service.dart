import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// The AuthenticationService authenticates the user
/// and provides the information needed for other classes
class AuthenticationService extends ChangeNotifier {
  /// The FirebaseAuth Object of the Project
  final FirebaseAuth _firebaseAuth;

  /// Constructor
  AuthenticationService(this._firebaseAuth);

  /// Returns the authStateChanges Stream from the FirebaseAuth
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  bool get isLoggedIn => uid != "";

  /// Tries to sign the user in
  Future<void> signIn(
    String email,
    String password, {
    void Function(String)? onComplete = log,
    void Function(String)? onError = log,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      onComplete!("Successfully signed in to Firebase");

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String? gerMessage = germanErrorVersion["auth/" + e.code];
      if (gerMessage != null) {
        onError!(gerMessage);
      } else {
        onError!(e.message != null
            ? e.message!
            : "Firebase Error with null message");
      }
    }
  }

  /// Tries to sign the user up
  Future<String> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
      return "Successfully signed in to Firebase";
    } on FirebaseAuthException catch (e) {
      return e.message != null
          ? e.message!
          : "Firebase Error with null message";
    }
  }

  /// returns the uid, and if the user isnt logged in return ""
  String get uid {
    if (_firebaseAuth.currentUser != null) {
      return _firebaseAuth.currentUser!.uid;
    }
    return "";
  }

  /// tells firebase that [email] wants to reset the password
  Future<String> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return "Successfully send password reset request to Firebase";
    } on FirebaseAuthException catch (e) {
      return e.message != null
          ? e.message!
          : "Firebase Error with null message";
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }

  static const Map<String, String> germanErrorVersion = {
    "auth/claims-too-large":
        "Die Ansprüche Nutzlast vorgesehen setCustomUserClaims() größer als die maximal zulässige Größe von 1000 Bytes.",
    "auth/email-already-exists":
        "Die angegebene E-Mail wird bereits von einem bestehenden Benutzer verwendet. Jeder Benutzer muss eine eindeutige E-Mail haben.",
    "auth/id-token-expired":
        "Das bereitgestellte Firebase-ID-Token ist abgelaufen.",
    "auth/id-token-revoked": "Das Firebase-ID-Token wurde widerrufen.",
    "auth/insufficient-permission":
        "Die zum Initialisieren des Admin-SDK verwendeten Anmeldeinformationen haben keine ausreichende Berechtigung zum Zugriff auf die angeforderte Authentifizierungsressource. Siehe ein Projekt Firebase einrichten für Dokumentation, wie eine Berechtigung mit dem entsprechenden Berechtigungen zu erzeugen , und es verwendet , um den Admin - SDKs zu authentifizieren.",
    "auth/internal-error":
        "Der Authentifizierungsserver hat beim Versuch, die Anforderung zu verarbeiten, einen unerwarteten Fehler festgestellt. Die Fehlermeldung sollte die Antwort des Authentifizierungsservers mit zusätzlichen Informationen enthalten. Wenn der Fehler weiterhin besteht, melden Sie bitte das Problem zu unserem Bug Report Support - Kanal.",
    "auth/invalid-argument":
        "Ein ungültiges Argument wurde einer Authentifizierungsmethode bereitgestellt. Die Fehlermeldung sollte zusätzliche Informationen enthalten.",
    "auth/invalid-claims":
        "Die benutzerdefinierte Anspruch Attribute bereitgestellt setCustomUserClaims() sind ungültig.",
    "auth/invalid-continue-uri":
        "Die Fortsetzungs-URL muss eine gültige URL-Zeichenfolge sein.",
    "auth/invalid-creation-time":
        "Die Erstellungszeit muss eine gültige UTC-Datumszeichenfolge sein.",
    "auth/invalid-credential":
        "Die zur Authentifizierung der Admin-SDKs verwendeten Anmeldeinformationen können nicht zum Ausführen der gewünschten Aktion verwendet werden. Bestimmte Authentifizierungsverfahren wie createCustomToken() und verifyIdToken() erfordern das SDK mit einem Zertifikat Nachweis für ein Aktualisierungs - Token oder Application Default Credential im Gegensatz initialisiert werden. Siehe Initialisieren des SDK für Dokumentation, wie die Admin SDKs mit einem Zertifikat Anmeldeinformationen zu authentifizieren.",
    "auth/invalid-disabled-field":
        "Der bereitgestellte Wert für die disabled Benutzereigenschaft ist unzulässig. Es muss ein boolescher Wert sein.",
    "auth/invalid-display-name":
        "Der bereitgestellte Wert für die displayName ist ungültig. Es muss eine nicht leere Zeichenfolge sein.",
    "auth/invalid-dynamic-link-domain":
        "Die bereitgestellte dynamische Linkdomäne ist für das aktuelle Projekt nicht konfiguriert oder autorisiert.",
    "auth/invalid-email":
        "Der bereitgestellte Wert für die email - email - Benutzereigenschaft ist ungültig. Es muss sich um eine String-E-Mail-Adresse handeln.",
    "auth/invalid-email-verified":
        "Der bereitgestellte Wert für die emailVerified Benutzereigenschaft ist ungültig. Es muss ein boolescher Wert sein.",
    "auth/invalid-hash-algorithm":
        "Der Hash-Algorithmus muss mit einer der Zeichenfolgen in der Liste der unterstützten Algorithmen übereinstimmen.",
    "auth/invalid-hash-block-size":
        "Die Hash-Blockgröße muss eine gültige Zahl sein.",
    "auth/invalid-hash-derived-key-length":
        "Die vom Hash abgeleitete Schlüssellänge muss eine gültige Zahl sein.",
    "auth/invalid-hash-key":
        "Der Hash-Schlüssel muss ein gültiger Byte-Puffer sein.",
    "auth/invalid-hash-memory-cost":
        "Die Hash-Speicherkosten müssen eine gültige Zahl sein.",
    "auth/invalid-hash-parallelization":
        "Die Hash-Parallelisierung muss eine gültige Zahl sein.",
    "auth/invalid-hash-rounds": "Die Hashrunden müssen eine gültige Zahl sein.",
    "auth/invalid-hash-salt-separator":
        "Das Salt-Separator-Feld des Hash-Algorithmus muss ein gültiger Byte-Puffer sein.",
    "auth/invalid-id-token":
        "Das bereitgestellte ID-Token ist kein gültiges Firebase-ID-Token.",
    "auth/invalid-last-sign-in-time":
        "Der Zeitpunkt der letzten Anmeldung muss eine gültige UTC-Datumszeichenfolge sein.",
    "auth/invalid-page-token":
        "Die bereitgestellten nächste Seite Token in listUsers() ist ungültig. Es muss sich um eine gültige, nicht leere Zeichenfolge handeln.",
    "auth/invalid-password":
        "Der angegebene Wert für die password Benutzereigenschaft ist ungültig. Es muss sich um eine Zeichenfolge mit mindestens sechs Zeichen handeln.",
    "auth/invalid-password-hash":
        "Der Passwort-Hash muss ein gültiger Byte-Puffer sein.",
    "auth/invalid-password-salt":
        "Der Passwort-Salt muss ein gültiger Byte-Puffer sein",
    "auth/invalid-phone-number":
        "Der bereitgestellte Wert für den phoneNumber ist ungültig. Es muss sich um eine nicht leere, mit dem E.164-Standard kompatible Kennungszeichenfolge handeln.",
    "auth/invalid-photo-url":
        "Der bereitgestellte Wert für die photoURL Benutzereigenschaft ist ungültig. Es muss sich um eine Zeichenfolgen-URL handeln.",
    "auth/invalid-provider-data":
        "Die providerData muss ein gültiges Array von UserInfo-Objekten sein.",
    "auth/invalid-provider-id":
        "Die providerId muss eine gültige unterstützte Anbieterkennungszeichenfolge sein.",
    "auth/invalid-oauth-responsetype":
        "Nur genau ein OAuth responseType sollte auf true gesetzt werden.",
    "auth/invalid-session-cookie-duration":
        "Die Dauer des Sitzungscookies muss eine gültige Zahl in Millisekunden zwischen 5 Minuten und 2 Wochen sein.",
    "auth/invalid-uid":
        "Die bereitgestellte uid muss eine nicht leere Zeichenkette mit maximal 128 Zeichen.",
    "auth/invalid-user-import":
        "Der zu importierende Benutzerdatensatz ist ungültig.",
    "auth/maximum-user-count-exceeded":
        "Die maximal zulässige Anzahl von Benutzern zum Importieren wurde überschritten.",
    "auth/missing-android-pkg-name":
        "Ein Android-Paketname muss angegeben werden, wenn die Android-App installiert werden muss.",
    "auth/missing-continue-uri":
        "In der Anfrage muss eine gültige Weiter-URL angegeben werden.",
    "auth/missing-hash-algorithm":
        "Das Importieren von Benutzern mit Kennwort-Hashes erfordert, dass der Hashing-Algorithmus und seine Parameter bereitgestellt werden.",
    "auth/missing-ios-bundle-id": "In der Anfrage fehlt eine Bundle-ID.",
    "auth/missing-uid":
        "Eine uid Identifikator wird für den aktuellen Betrieb erforderlich.",
    "auth/missing-oauth-client-secret":
        "Der geheime OAuth-Konfigurationsclient ist erforderlich, um den OIDC-Codefluss zu aktivieren.",
    "auth/operation-not-allowed":
        "Der angegebene Anmeldeanbieter ist für Ihr Firebase-Projekt deaktiviert. Aktivieren Sie es aus dem Sign-in - Methode Abschnitt der Konsole Firebase.",
    "auth/phone-number-already-exists":
        "Der mitgelieferte phoneNumber ist bereits von einem vorhandenen Benutzer. Jeder Benutzer muss eine eindeutige haben phoneNumber .",
    "auth/project-not-found":
        "Für die zum Initialisieren der Admin-SDKs verwendeten Anmeldeinformationen wurde kein Firebase-Projekt gefunden. Siehe ein Projekt Firebase einrichten für Dokumentation, wie eine Berechtigung für Ihr Projekt zu generieren und es verwenden , um die Admin - SDKs zu authentifizieren.",
    "auth/reserved-claims":
        "Eine oder mehrere benutzerdefinierte Ansprüche bereitgestellt setCustomUserClaims() sind reserviert. Zum Beispiel OIDC spezifische Ansprüche wie (sub, iat, iss, exp, AUD, auth_time, usw.) sollen nicht als Schlüssel für die individuellen Ansprüche verwendet werden.",
    "auth/session-cookie-expired":
        "Das bereitgestellte Firebase-Sitzungscookie ist abgelaufen.",
    "auth/session-cookie-revoked":
        "Das Firebase-Sitzungscookie wurde widerrufen.",
    "auth/uid-already-exists":
        "Die bereitgestellte uid ist bereits von einem vorhandenen Benutzer. Jeder Benutzer muss eine eindeutige haben uid .",
    "auth/unauthorized-continue-uri":
        "Die Domain der Weiter-URL steht nicht auf der Whitelist. Setzen Sie die Domain in der Firebase Console auf die Whitelist.",
    "auth/user-not-found":
        "Es gibt keinen vorhandenen Benutzerdatensatz, der der bereitgestellten Kennung entspricht.",
  };
}

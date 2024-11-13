const translationKeys = (
  academyScreen: (
    labelButton: 'academy_screen.label-button', // Zum YouTube-Kanal
    labelDescription:
        'academy_screen.label-description', // Die Invest it! Academy hilft dir dabei, dich in der Wirtschafts- und Finanzwelt zurechtzufinden. Wir produzieren kostenlose, unparteiische Lernvideos für dich. Jetzt reinschauen!
    labelTitle: 'academy_screen.label-title' // Finanzen einfach erklärt.
  ),
  actionLip: (
    changeEmail: (
      buttonSubmit:
          'action_lip.change-email.button-submit', // E-Mail-Adresse jetzt ändern
      labelDescription:
          'action_lip.change-email.label-description', // Bitte trage die neue E-Mail-Adresse ein.
      labelTitle:
          'action_lip.change-email.label-title', // E-Mail-Adresse ändern
      hintLabel: 'action_lip.change-email.hint-label', // Neue E-Mail-Adresse
      hintLabelRepeat:
          'action_lip.change-email.hint-label-repeat', // Neue E-Mail-Adresse wiederholen
      emailRepeatMismatchError:
          'action_lip.change-email.email-repeat-mismatch-error', // Die E-Mail-Adressen stimmen nicht überein
      emailNotValid:
          'action_lip.change-email.email-not-valid' // Bitte gib eine valide E-Mail-Adressen ein
    ),
    forgotPassword: (
      loggedIn: (
        buttonSubmit:
            'action_lip.forgot-password.logged-in.button-submit', // Passwort jetzt ändern
        labelDescription:
            'action_lip.forgot-password.logged-in.label-description', // Bitte trage ein neues Passwort ein. Passwörter, die du bereits verwendet hast, sind nicht zulässig. Ebenso darf deine E-Mail-Adresse nicht darin vorkommen und es muss länger als 6 Zeichen sein.
        labelTitle:
            'action_lip.forgot-password.logged-in.label-title' // Passwort ändern
      ),
      loggedOut: (
        buttonSubmit:
            'action_lip.forgot-password.logged-out.button-submit', // Code anfordern
        labelDescription:
            'action_lip.forgot-password.logged-out.label-description', // Bitte trage deine E-Mail-Adresse ein, die mit deinem Account verbunden ist. Wir schicken die einen Verifizierungscode zu, mit dem du dein Passwort neu setzen kannst.
        labelTitle:
            'action_lip.forgot-password.logged-out.label-title' // Passwort zurücksetzen
      )
    ),
    standardCategory: (
      expenses: (
        labelTitle:
            'action_lip.standard-category.expenses.label-title' // Ausgaben
      ),
      income: (
        labelTitle:
            'action_lip.standard-category.income.label-title' // Einnahmen
      )
    ),
    standardCurrency: (
      labelTitle: 'action_lip.standard-currency.label-title' // Währung
    )
  ),
  alertdialog: (
    deleteAccount: (
      action: 'alertdialog.delete-account.action', // Ja, Account löschen
      cancel: 'alertdialog.delete-account.cancel', // Abbrechen
      message:
          'alertdialog.delete-account.message', // Diese Aktion kann nicht rückgängig gemacht werden!
      title:
          'alertdialog.delete-account.title' // Möchtest du deinen Account wirklich löschen?
    ),
    error: (
      actionStandard: 'alertdialog.error.action-standard', // Okay
      messageStandard:
          'alertdialog.error.message-standard', // Ein unbekannter Fehler ist aufgetreten.
      titleStandard: 'alertdialog.error.title-standard' // Fehler
    ),
    killswitchChange: (
      action: 'alertdialog.killswitch-change.action', // Trotzdem abbrechen
      cancel: 'alertdialog.killswitch-change.cancel', // Zurück
      message:
          'alertdialog.killswitch-change.message', // Wenn du den Vorgang jetzt abbrichst, bleibt die alte PIN aktiv.
      title: 'alertdialog.killswitch-change.title' // Bist du sicher?
    ),
    killswitchInitialize: (
      action: 'alertdialog.killswitch-initialize.action', // Trotzdem abbrechen
      cancel: 'alertdialog.killswitch-initialize.cancel', // Zurück
      message:
          'alertdialog.killswitch-initialize.message', // Wenn du den Vorgang jetzt abbrichst, wird die PIN-Sperre wieder deaktiviert.
      title: 'alertdialog.killswitch-initialize.title' // Bist du sicher?
    ),
    killswitchRecall: (
      action:
          'alertdialog.killswitch-recall.action', // Abmelden und PIN zurücksetzen
      cancel: 'alertdialog.killswitch-recall.cancel', // Nicht abmelden
      message:
          'alertdialog.killswitch-recall.message', // Wenn du dich abmeldest, wird die PIN-Sperre deaktiviert. So kannst du dich normal mit deiner E-Mail und deinem Passwort anmelden, falls du deinen PIN-Code vergessen hast.
      title: 'alertdialog.killswitch-recall.title' // Bist du sicher?
    ),
    login: (
      actionStandard: 'alertdialog.login.action-standard', // Okay
      titleStandard:
          'alertdialog.login.title-standard' // Anmeldung nicht erfolgreich
    ),
    loginVerification: (
      action: 'alertdialog.login-verification.action', // Okay
      message:
          'alertdialog.login-verification.message', // Du hast deine E-Mail-Adresse noch nicht bestätigt. Wir haben dir eine neue E-Mail zum Bestätigen deiner Registrierung geschickt. Bitte klicke auf den Link in der E-Mail, um deinen Account zu aktivieren. Bitte überprüfe auch deinen Spam-Ordner.
      title: 'alertdialog.login-verification.title' // E-Mail nicht bestätigt
    ),
    resetPassword: (
      action: 'alertdialog.reset-password.action', // Okay
      message:
          'alertdialog.reset-password.message', // Wir haben dir einen Link zum Zurücksetzen deines Passworts geschickt. Bitte klicke auf den Link in der E-Mail, um ein neues Passwort zu setzen. Bitte überprüfe auch deinen Spam-Ordner.
      title: 'alertdialog.reset-password.title' // Anfrage gesendet
    ),
    signupVerification: (
      action: 'alertdialog.signup-verification.action', // Okay
      message:
          'alertdialog.signup-verification.message', // Wir haben dir einen Link zum Bestätigen deiner Registrierung geschickt. Bitte klicke auf den Link in der E-Mail, um deinen Account zu aktivieren. Bitte überprüfe auch deinen Spam-Ordner.
      title: 'alertdialog.signup-verification.title' // Registrierung bestätigen
    ),
    updatePassword: (
      action: 'alertdialog.update-password.action', // Okay
      message:
          'alertdialog.update-password.message', // Dein Passwort wurde aktualisiert.
      title: 'alertdialog.update-password.title' // Fertig!
    ),
    updateEmail: (
      action: 'alertdialog.update-email.action', // Okay
      message:
          'alertdialog.update-email.message', // Deine E-Mail-Adresse wurde aktualisiert.
      title: 'alertdialog.update-email.title' // Fertig!
    ),
    deleteTransaction: (
      dialogButtonCancel:
          'alertdialog.delete-transaction.dialog-button-cancel', // Abbrechen
      dialogButtonDelete:
          'alertdialog.delete-transaction.dialog-button-delete', // Löschen
      dialogMessage:
          'alertdialog.delete-transaction.dialog-message', // Möchtest du diesen Eintrag wirklich löschen?
      dialogMessageSerial:
          'alertdialog.delete-transaction.dialog-message-serial', // Möchtest du diesen Vertrag wirklich löschen? Dadurch werden alle über den Vertrag gebuchten Transaktionen gelöscht.
      dialogLabelTitle:
          'alertdialog.delete-transaction.dialog-label-title' // Löschen bestätigen
    )
  ),
  auth: (
    claimsTooLarge:
        'auth.claims-too-large', // Es gehen mehr Anfragen als zulässig ein. Bitte versuche es später noch einmal.
    emailAlreadyExists:
        'auth.email-already-exists', // Die angegebene E-Mail wird bereits verwendet.
    emailAlreadyInUse:
        'auth.email-already-in-use', // Zu der angegebenen E-Mail-Adresse existiert bereits ein Konto. Falls du das Passwort vergessen hast, kannst du es jederzeit über die 'Passwort zurücksetzen'-Funktion zurücksetzen.
    idTokenExpired:
        'auth.id-token-expired', // Das Authentication-ID-Token ist abgelaufen.
    idTokenRevoked:
        'auth.id-token-revoked', // Das Authentication-ID-Token wurde widerrufen.
    insufficientPermission:
        'auth.insufficient-permission', // Dein Account hat nicht die Berechtigung, sich hier anzumelden. Bitte prüfe deine Anmeldedaten.
    internalError:
        'auth.internal-error', // Es ist ein interner Fehler aufgetreten. Bitte melde dich bei support@investit-academy.de
    invalidArgument:
        'auth.invalid-argument', // Du hast eine ungültige Anmeldeangabe gemacht. Bitte melde dich bei support@investit-academy.de
    invalidClaims:
        'auth.invalid-claims', // Du hast eine Anmeldeanfrage ausgelöst, die nicht erlaubt ist. Bitte melde dich bei support@investit-academy.de
    invalidContinueUri:
        'auth.invalid-continue-uri', // Es ist ein interner Fehler aufgetreten. Bitte versuche es später noch einmal.
    invalidCreationTime:
        'auth.invalid-creation-time', // Der Server konnte deine Zeitzone nicht validieren. Bitte prüfe, ob die Zeit auf deinem Handy richtig eingestellt ist.
    invalidCredential:
        'auth.invalid-credential', // Die Anmeldeinformationen können nicht für die Anmeldung verwendet werden. Bitte melde dich bei support@investit-academy.de
    invalidDisabledField:
        'auth.invalid-disabled-field', // Wenn du diesen Fehler siehst, haben wir etwas völlig falsch gemacht. Bitte melde dich bei support@investit-academy.de
    invalidDisplayName:
        'auth.invalid-display-name', // Dein Nutzername ist ungültig.
    invalidEmail:
        'auth.invalid-email', // Deine E-Mail-Adresse ist ungültig. Vielleicht hast du dich vertippt?
    invalidEmailVerified:
        'auth.invalid-email-verified', // Deine E-Mail-Adresse konnte nicht verifiziert werden. Vielleicht hast du dich vertippt?
    invalidIdToken:
        'auth.invalid-id-token', // Die Verbindung zum Server war fehlerhaft. Bitte melde dich bei support@investit-academy.de
    invalidLastSignInTime:
        'auth.invalid-last-sign-in-time', // Der Server konnte deine Zeitzone nicht validieren. Bitte prüfe, ob die Zeit auf deinem Handy richtig eingestellt ist.
    invalidOauthResponsetype:
        'auth.invalid-oauth-responsetype', // Es gab einen Fehler bei OAuth. Bitte melde dich bei support@investit-academy.de
    invalidPassword:
        'auth.invalid-password', // Deine E-Mail oder dein Passwort sind nicht korrekt. Vielleicht hast du dich vertippt?
    invalidPhoneNumber:
        'auth.invalid-phone-number', // Die Telefonnummer ist ungültig.
    invalidPhotoUrl:
        'auth.invalid-photo-url', // Die Datei für dein Profilbild ist fehlerhaft. Bitte melde dich bei support@investit-academy.de
    invalidSessionCookieDuration:
        'auth.invalid-session-cookie-duration', // Ein notwendiger Cookie konnte nicht gesetzt werden. Bitte melde dich bei support@investit-academy.de
    invalidUid:
        'auth.invalid-uid', // Deine User-ID ist fehlerhaft. Bitte melde dich bei support@investit-academy.de
    missingAndroidPkgName:
        'auth.missing-android-pkg-name', // Die App-Daten auf deinem Gerät sind fehlerhaft. Bitte installiere die App neu. Falls der Fehler weiterhin auftritt, melde dich bei support@investit-academy.de
    missingContinueUri:
        'auth.missing-continue-uri', // Deine Anmeldeanfrage konnte nicht verarbeitet werden. Bitte melde dich bei support@investit-academy.de
    missingIosBundleId:
        'auth.missing-ios-bundle-id', // Die App-Daten auf deinem Gerät sind fehlerhaft. Bitte installiere die App neu. Falls der Fehler weiterhin auftritt, melde dich bei support@investit-academy.de
    missingOauthClientSecret:
        'auth.missing-oauth-client-secret', // Deine Anmeldung konnte nicht verarbeitet werden. Bitte melde dich bei support@investit-academy.de
    missingUid:
        'auth.missing-uid', // Deine User-ID konnte nicht geladen werden. Bitte starte die App neu. Wenn das Problem weiterhin besteht, melde dich bei support@investit-academy.de
    networkRequestFailed:
        'auth.network-request-failed', // Der Server konnte nicht kontaktiert werden (Timeout).
    notLoggedInToUpdatePassword:
        'auth.not-logged-in-to-update-password', // Um dein Passwort zu ändern, musst du angemeldet sein. Wenn du dein Passwort vergessen hast, kannst du stattdessen eine E-Mail zum Zurücksetzen deines Passworts anfordern.
    notLoggedInToUpdateEmail:
        'auth.not-logged-in-to-update-email', // Um deine E-Mmail-Adresse zu ändern, musst du angemeldet sein.
    notLoggedInToVerify:
        'auth.not-logged-in-to-verify', // Um eine Verifikations-Email anzufordern, musst du angemeldet sein.
    operationNotAllowed:
        'auth.operation-not-allowed', // Der Anmeldedienst ist derzeit deaktiviert. Bitte versuche es später noch einmal.
    phoneNumberAlreadyExists:
        'auth.phone-number-already-exists', // Diese Telefonnummer existiert bereits.
    projectNotFound:
        'auth.project-not-found', // Die Verbindung zum Server konnte nicht hergestellt werden. Bitte melde dich bei support@investit-academy.de
    requiresRecentLogin:
        'auth.requires-recent-login', // Bitte melde dich aus Sicherheitsgründen zunächst an.
    sessionCookieExpired:
        'auth.session-cookie-expired', // Während deiner Anfrage ist ein Cookie abgelaufen. Bitte logge dich aus und starte die App neu.
    sessionCookieRevoked:
        'auth.session-cookie-revoked', // Während deiner Anfrage ist ein Cookie widerrufen worden. Bitte logge dich aus und starte die App neu.
    tooManyRequests:
        'auth.too-many-requests', // Es wurden zu viele Registrierungsanfragen gesendet. Bitte versuchen Sie es später noch einmal.
    uidAlreadyExists:
        'auth.uid-already-exists', // Deine Benutzer-ID konnte nicht gesetzt werden. Bitte versuche, dich erneut zu registrieren.
    unauthorizedContinueUri:
        'auth.unauthorized-continue-uri', // Deine Anmeldeanfrage konnte nicht verarbeitet werden. Bitte melde dich bei support@investit-academy.de
    unknown:
        'auth.unknown', // Es ist ein unbekannter Fehler aufgetreten. Bitte kontaktieren Sie support@investit-academy.de
    userDisabled:
        'auth.user-disabled', // Der Benutzer wurde vom System deaktiviert. Falls du denkst, dass dies ein Fehler ist, wende dich bitte an support@investit-academy.de
    userDeleted:
        'auth.user-deleted', // Der Benutzer wurde erfolgreich gelöscht!
    userNotFound:
        'auth.user-not-found', // Deine E-Mail oder dein Passwort sind nicht korrekt. Vielleicht hast du dich vertippt?
    emailNotFound:
        'auth.email-not-found', // Wir konnten keinen Benutzer mit der von dir angegebenen E-Mail-Adresse finden. Vielleicht hast du dich vertippt?
    weakPassword:
        'auth.weak-password', // Das eingegebene Passwort ist zu schwach. Bitte wähle ein stärkeres Passwort.
    wrongPassword:
        'auth.wrong-password' // Deine E-Mail oder dein Passwort sind nicht korrekt. Vielleicht hast du dich vertippt?
  ),
  budgetScreen: (
    buttonFilter: 'budget_screen.button-filter', // Filter
    labelAllTransactions:
        'budget_screen.label-all-transactions', // Alle Transaktionen
    common: (
      labelRemaining: 'budget_screen.common.label-remaining', // verbleibend
      labelExceeded: 'budget_screen.common.label-exceeded' // überschritten
    )
  ),
  currency: (
    error: (
      notFound: 'currency.error.not-found' // Währung wird nicht unterstützt
    ),
    name: (
      aud: 'currency.name.aud', // Australischer Dollar
      brl: 'currency.name.brl', // Brasilianischer Real
      cad: 'currency.name.cad', // Kanadischer Dollar
      chf: 'currency.name.chf', // Schweizer Franken
      cny: 'currency.name.cny', // Chinesischer Yuan
      czk: 'currency.name.czk', // Tschechische Krone
      dkk: 'currency.name.dkk', // Dänische Krone
      eur: 'currency.name.eur', // Euro
      gbp: 'currency.name.gbp', // Britisches Pfund
      idr: 'currency.name.idr', // Indonesische Rupiah
      ils: 'currency.name.ils', // Schekel
      inr: 'currency.name.inr', // Indische Rupie
      isk: 'currency.name.isk', // Isländische Krone
      jpy: 'currency.name.jpy', // Yen
      krw: 'currency.name.krw', // Südkoreanischer Won
      mxn: 'currency.name.mxn', // Mexikanischer Peso
      myr: 'currency.name.myr', // Malaysischer Ringgit
      nok: 'currency.name.nok', // Norwegische Krone
      nzd: 'currency.name.nzd', // Neuseeland-Dollar
      pln: 'currency.name.pln', // Złoty
      sek: 'currency.name.sek', // Schwedische Krone
      thb: 'currency.name.thb', // Baht
      tyr: 'currency.name.tyr', // Türkische Lira
      usd: 'currency.name.usd', // US Dollar
      zar: 'currency.name.zar' // Südafrikanischer Rand
    )
  ),
  enterScreen: (
    entryTypeSelection: (
      title:
          'enter_screen.entry-type-selection.title' // Wähle die Art der Transaktion
    ),
    inputFlag: (
      category: 'enter_screen.input_flag.category', // Kategorie
      repeatInfo: 'enter_screen.input_flag.repeat_info', // Wiederholung
      date: 'enter_screen.input_flag.date' // Datum
    ),
    date: (
      monday: 'enter_screen.date.monday', // Montag
      tuesday: 'enter_screen.date.tuesday', // Dienstag
      wednesday: 'enter_screen.date.wednesday', // Mittwoch
      thursday: 'enter_screen.date.thursday', // Donnerstag
      friday: 'enter_screen.date.friday', // Freitag
      saturday: 'enter_screen.date.saturday', // Samstag
      sunday: 'enter_screen.date.sunday' // Sonntag
    ),
    repeat: (
      thirtyDays: 'enter_screen.repeat.thirty_days', // Monatlich
      annually: 'enter_screen.repeat.annually', // Jährlich
      daily: 'enter_screen.repeat.daily', // Täglich
      freeselect: 'enter_screen.repeat.freeselect', // Frei auswählen
      monthly: 'enter_screen.repeat.monthly', // Zum Monatsanfang
      none: 'enter_screen.repeat.none', // Nicht wiederholen
      quarterly: 'enter_screen.repeat.quarterly', // Alle 3 Monate
      semiannually: 'enter_screen.repeat.semiannually', // Halbjährlich
      weekly: 'enter_screen.repeat.weekly', // Wöchentlich
      custom: 'enter_screen.repeat.custom' // Benutzerdefiniert
    ),
    specialDate: (
      yesterday: 'enter_screen.special_date.yesterday', // Gestern
      tomorrow: 'enter_screen.special_date.tomorrow', // Morgen
      today: 'enter_screen.special_date.today' // Heute
    ),
    addAmount: (
      dialogLabelTitle: 'enter_screen.add-amount.dialog-label-title', // Okay!
      dialogLabelTitleExpenses:
          'enter_screen.add-amount.dialog-label-title-expenses', // Bitte füge einen Betrag zu deiner Ausgabe hinzu!
      dialogLabelTitleIncome:
          'enter_screen.add-amount.dialog-label-title-income', // Bitte füge einen Betrag zu deinem Einkommen hinzu!
      parserStartWithAmountError:
          'enter_screen.add-amount.parser-start-with-amount-error' // Bitte tippe zuerst den Betrag ein
    ),
    button: (
      expensesLabel: 'enter_screen.button.expenses-label', // Ausgabe
      incomeLabel: 'enter_screen.button.income-label', // Einnahme
      saveNote: 'enter_screen.button.save-note', // Notiz speichern
      close: 'enter_screen.button.close' // Schließen
    ),
    changeEntry: (
      dialogLabelChange:
          'enter_screen.change-entry.dialog-label-change' // Welchen Eintrag möchtest du ändern?
    ),
    menu: (
      category: 'enter_screen.menu.category', // Kategorie
      currency: 'enter_screen.menu.currency', // Währung
      date: 'enter_screen.menu.date', // Datum
      repeatConfig: 'enter_screen.menu.repeat-config', // Wiederholung
      notes: 'enter_screen.menu.notes' // Notizen
    ),
    enterNoteHint: 'enter_screen.enter-note-hint', // Notizen hier eintragen
    changeModeSelection: (
      title: (
        delete:
            'enter_screen.change-mode-selection.title.delete', // Wiederkehrende Einträge löschen
        save:
            'enter_screen.change-mode-selection.title.save' // Wiederkehrende Einträge ändern
      ),
      all: 'enter_screen.change-mode-selection.all', // Alle Einträge
      thisAndAllAfter:
          'enter_screen.change-mode-selection.this-and-all-after', // Diesen Eintrag und alle folgenden
      onlyThisOne:
          'enter_screen.change-mode-selection.only-this-one', // Diesen Eintrag
      thisAndAllBefore:
          'enter_screen.change-mode-selection.this-and-all-before' // Diesen Eintrag und alle vorherigen
    ),
    expensesTextfieldTitle:
        'enter_screen.expenses-textfield-title', // Was hast du gekauft?
    incomeTextfieldTitle:
        'enter_screen.income-textfield-title', // Wie heißt dieses Einkommen?
    title: (
      add: 'enter_screen.title.add', // Neuer Eintrag
      edit: 'enter_screen.title.edit' // Eintrag bearbeiten
    ),
    transactionTextfieldTitle:
        'enter_screen.transaction-textfield-title' // Wie heißt diese Transaktion?
  ),
  homeScreen: (
    buttonShowAll: 'home_screen.button-show-all', // Alle
    buttonShowMore: 'home_screen.button-show-more', // Mehr
    freeText: 'home_screen.free-text', // Gratis
    labelActiveSerialcontracts:
        'home_screen.label-active-serialcontracts', // Verträge diesen Monat
    labelRecentTransactions:
        'home_screen.label-recent-transactions' // Neueste Transaktionen
  ),
  homeScreenCard: (
    homeScreenCardToast:
        'home_screen_card.home-screen-card-toast', // Swipe nach links und rechts, um vorige oder kommende Monate anzusehen. Gedrückt halten, um in den aktuellen Monat zurückzukehren.
    labelCurrentBalance:
        'home_screen_card.label-current-balance', // Aktuelle Monatsbilanz
    labelExpenses: 'home_screen_card.label-expenses', // Ausgaben
    labelIncome: 'home_screen_card.label-income', // Einnahmen
    labelTotalBalance: 'home_screen_card.label-total-balance', // Kontostand
    labelTotalBalanceSub:
        'home_screen_card.label-total-balance-sub', // bis Heute
    labelMonthlyPlanner:
        'home_screen_card.label-monthly-planner', // Monatsplaner
    labelMtdBalance: 'home_screen_card.label-mtd-balance', // Bilanz bisher
    labelContracts: 'home_screen_card.label-contracts', // ± Verträge
    labelEomProjectedBalance:
        'home_screen_card.label-eom-projected-balance', // Endbilanz
    labelAccountPositionMonth:
        'home_screen_card.label-account-position-month' // Kontostand Monatsanfang bis -Ende
  ),
  listview: (
    dismissible: (
      labelDelete: 'listview.dismissible.label-delete' // Löschen
    ),
    labelDays: 'listview.label-days', // Tage
    labelErrorTranslation:
        'listview.label-error-translation', // Übersetzung fehlt
    labelEvery: 'listview.label-every', // Alle
    labelFuture: 'listview.label-future', // Geplante Buchungen
    labelLastweek: 'listview.label-lastweek', // Letzte Woche
    labelMonths: 'listview.label-months', // Monate
    labelNoEntries: 'listview.label-no-entries', // - Keine Einträge bisher -
    labelThismonth: 'listview.label-thismonth', // Diesen Monat
    labelToday: 'listview.label-today', // Heute
    labelWeeks: 'listview.label-weeks', // Wochen
    labelYears: 'listview.label-years', // Jahre
    labelYesterday: 'listview.label-yesterday' // Gestern
  ),
  lockScreen: (
    change: (
      labelButton: 'lock_screen.change.label-button', // Abbrechen
      labelTitle: 'lock_screen.change.label-title' // Wähle eine neue PIN
    ),
    errors: (
      lastMailMissing:
          'lock_screen.errors.last-mail-missing' // Die PIN konnte keinem Account zugewiesen werden
    ),
    initialize: (
      labelButton: 'lock_screen.initialize.label-button', // Abbrechen
      labelTitle: 'lock_screen.initialize.label-title' // Wähle deine PIN
    ),
    recall: (
      labelButton: 'lock_screen.recall.label-button', // Abmelden
      labelTitle: 'lock_screen.recall.label-title' // Bitte PIN eingeben
    ),
    toastPinChanged:
        'lock_screen.toast-pin-changed', // Die PIN wurde erfolgreich geändert.
    toastPinDeactivated:
        'lock_screen.toast-pin-deactivated', // Die PIN-Sperre wurde deaktiviert.
    toastPinSet:
        'lock_screen.toast-pin-set', // Du hast die PIN-Sperre erfolgreich aktiviert!
    toastWrongCode:
        'lock_screen.toast-wrong-code' // Der eingegebene Code ist falsch
  ),
  logoutForm: (
    labelCurrentEmail: 'logout_form.label-current-email' // Angemeldet als:
  ),
  main: (
    labelError: 'main.label-error', // Ein Fehler ist aufgetreten.
    labelLoading: 'main.label-loading', // Laden...
    labelWip:
        'main.label-wip' // Hier wird noch gearbeitet. Schau gerne später vorbei!
  ),
  onboardingScreen: (
    appleButton: 'onboarding_screen.apple-button', // Mit Apple fortfahren
    card1Description:
        'onboarding_screen.card1-description', // Dein neuer Budgeting-Assistent wartet schon auf dich.
    card1Title: 'onboarding_screen.card1-title', // Herzlich Willkommen!
    card2Description:
        'onboarding_screen.card2-description', // So einfach war's noch nie: Mit unserer Tracking-Funktion weißt du immer genau, wie viel Geld du gerade hast.
    card2Title: 'onboarding_screen.card2-title', // Tracke dein Geld
    card3Description:
        'onboarding_screen.card3-description', // Über unser Academy-Feature bekommst du eine große Auswahl an kostenlosen Videos zu vielen Themen aus der Finanzwelt!
    card3Title: 'onboarding_screen.card3-title', // Sei bestens vorbereitet
    card4Description:
        'onboarding_screen.card4-description', // Linum generiert ganz automatisch relevante Statistiken für dich. So kannst du nachvollziehen, wie du mit deinem Budget umgehst.
    card4Title: 'onboarding_screen.card4-title', // Behalte den Überblick
    ctaLogin:
        'onboarding_screen.cta-login', // Du hast einen Account? Hier einloggen
    ctaRegister:
        'onboarding_screen.cta-register', // Noch keinen Account? Hier registrieren
    googleButton: 'onboarding_screen.google-button', // Mit Google fortfahren
    loginButton: 'onboarding_screen.login-button', // Ich habe einen Account
    loginEmailErrorlabel:
        'onboarding_screen.login-email-errorlabel', // Bitte gib eine gültige E-Mail-Adresse ein.
    loginEmailHintlabel:
        'onboarding_screen.login-email-hintlabel', // E-Mail-Adresse
    loginLipForgotPasswordButton:
        'onboarding_screen.login-lip-forgot-password-button', // Passwort vergessen?
    loginLipLoginButton: 'onboarding_screen.login-lip-login-button', // Anmelden
    loginLipTitle: 'onboarding_screen.login-lip-title', // LOGIN
    loginPasswordErrorlabel:
        'onboarding_screen.login-password-errorlabel', // Bitte gib dein Passwort ein.
    loginPasswordHintlabel:
        'onboarding_screen.login-password-hintlabel', // Passwort
    registerButton: 'onboarding_screen.register-button', // Jetzt registrieren!
    registerEmailErrorlabel:
        'onboarding_screen.register-email-errorlabel', // Bitte gib eine gültige E-Mail-Adresse ein.
    registerEmailHintlabel:
        'onboarding_screen.register-email-hintlabel', // E-Mail-Adresse
    registerLipForgotPasswordButton:
        'onboarding_screen.register-lip-forgot-password-button', // Alternative sign-in methoden
    registerLipSignupButton:
        'onboarding_screen.register-lip-signup-button', // Registrieren
    registerLipTitle: 'onboarding_screen.register-lip-title', // Registrieren
    registerPasswordErrorlabel:
        'onboarding_screen.register-password-errorlabel', // Bitte gib ein Passwort mit mindestens 6 Zeichen ein.
    registerPasswordHintlabel:
        'onboarding_screen.register-password-hintlabel', // Passwort
    registerPrivacy: (
      labelLeading:
          'onboarding_screen.register-privacy.label-leading', // Durch die Anmeldung erklärst du dich mit unserer
      labelLink:
          'onboarding_screen.register-privacy.label-link', // Datenschutzerklärung
      labelTrailing:
          'onboarding_screen.register-privacy.label-trailing' //  einverstanden.
    ),
    svgCreditLabel:
        'onboarding_screen.svg-credit-label' // Illustrationen von Freepik
  ),
  settingsScreen: (
    languageSettings: (
      labelDe: 'settings_screen.language-settings.label-de', // English
      labelEn: 'settings_screen.language-settings.label-en', // Deutsch
      labelNl: 'settings_screen.language-settings.label-nl', // Nederlands
      labelSystemlang:
          'settings_screen.language-settings.label-systemlang', // Systemsprache verwenden
      labelTitle:
          'settings_screen.language-settings.label-title', // Spracheinstellungen
      labelTooltip:
          'settings_screen.language-settings.label-tooltip' // Im Moment kann nur die Systemsprache verwendet werden. Unterstützte Sprachen: Deutsch, Englisch.
    ),
    pinLock: (
      labelChangePin:
          'settings_screen.pin-lock.label-change-pin', // PIN-Code ändern
      labelTitle: 'settings_screen.pin-lock.label-title', // PIN-Sperre
      labelTooltip:
          'settings_screen.pin-lock.label-tooltip', // Ist die PIN-Sperre aktiv, musst du beim Starten der App zum Schutz deiner Daten deinen persönlichen PIN-Code eingeben.
      switchLabel: 'settings_screen.pin-lock.switch-label' // PIN-Sperre aktiv
    ),
    specialSettings: (
      labelSchwabenmodus:
          'settings_screen.special-settings.label-schwabenmodus', // Schwabenmodus
      labelTitle:
          'settings_screen.special-settings.label-title' // Besondere Einstellungen
    ),
    standardAccount: (
      labelTitle:
          'settings_screen.standard-account.label-title', // Standard-Accounts
      labelTooltip:
          'settings_screen.standard-account.label-tooltip' // Diese Accounts werden standardmäßig bei jeder neuen Einnahme/Ausgabe genutzt. Du kannst diese auch individuell ändern.
    ),
    standardAccountSelector: (
      cash: 'settings_screen.standard-account-selector.cash', // Bargeld
      creditCard:
          'settings_screen.standard-account-selector.credit-card', // Kreditkarte
      debitCard:
          'settings_screen.standard-account-selector.debit-card', // Debitkarte
      deposit: 'settings_screen.standard-account-selector.deposit', // Depot
      labelTitle:
          'settings_screen.standard-account-selector.label-title', // Transaktionen:
      modalLabelTitle:
          'settings_screen.standard-account-selector.modal-label-title' // Accounts
    ),
    standardCategory: (
      labelTitle:
          'settings_screen.standard-category.label-title', // Standard-Kategorien
      labelTooltip:
          'settings_screen.standard-category.label-tooltip' // Diese Kategorien werden standardmäßig bei jeder neuen Einnahme/Ausgabe/Transaktion genutzt. Du kannst diese auch individuell ändern.
    ),
    standardCurrency: (
      labelTitle:
          'settings_screen.standard-currency.label-title', // Standard-Währung
      labelTooltip:
          'settings_screen.standard-currency.label-tooltip' // Diese Währung wird standardmäßig bei jeder neuen Transaktion genutzt. Du kannst diese auch individuell ändern.
    ),
    standardExpenseSelector: (
      car: 'settings_screen.standard-expense-selector.car', // Auto & Transport
      food: 'settings_screen.standard-expense-selector.food', // Essen & Trinken
      freetime:
          'settings_screen.standard-expense-selector.freetime', // Freizeit
      house: 'settings_screen.standard-expense-selector.house', // Haus & Wohnen
      labelTitle:
          'settings_screen.standard-expense-selector.label-title', // Ausgaben:
      lifestyle:
          'settings_screen.standard-expense-selector.lifestyle', // Lifestyle
      misc: 'settings_screen.standard-expense-selector.misc' // Verschiedenes
    ),
    standardIncomeSelector: (
      allowance:
          'settings_screen.standard-income-selector.allowance', // Taschengeld
      childsupport:
          'settings_screen.standard-income-selector.childsupport', // Kindergeld
      interest: 'settings_screen.standard-income-selector.interest', // Zinsen
      investments:
          'settings_screen.standard-income-selector.investments', // Investitionen
      labelTitle:
          'settings_screen.standard-income-selector.label-title', // Einnahmen:
      misc: 'settings_screen.standard-income-selector.misc', // Verschiedenes
      salary: 'settings_screen.standard-income-selector.salary', // Gehalt
      sidejob: 'settings_screen.standard-income-selector.sidejob' // Nebenjob
    ),
    standardsSelectorNone:
        'settings_screen.standards-selector-none', // Unkategorisiert
    systemSettings: (
      buttonChangeEmail:
          'settings_screen.system-settings.button-change-email', // E-Mail-Adresse ändern
      buttonDeleteUser:
          'settings_screen.system-settings.button-delete-user', // Account löschen
      buttonForgotPassword:
          'settings_screen.system-settings.button-forgot-password', // Passwort ändern
      buttonForgotPasswordTooltip:
          'settings_screen.system-settings.button-forgot-password-tooltip', // Falls du dein Passwort vergessen hast, kannst du hier ein neues einstellen.
      buttonSignout:
          'settings_screen.system-settings.button-signout', // Ausloggen
      labelTitle: 'settings_screen.system-settings.label-title' // Dein Account
    )
  )
);

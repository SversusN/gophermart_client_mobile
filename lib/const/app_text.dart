class F3MobileText {
  static const invoiceLoadingDataMessage = 'Загружаем позиции...';
  static const invoiceLoadingDataErrorMessage =
      'При загрузке накладной произошла ошибка.';
  static const invoiceItemSeriesLabel = 'Серия';
  static const invoiceItemSeriesTextNone = '(не указана)';
  static const invoiceItemQuantityLabel = 'Количество:';
  static const invoiceItemKizCompletedLabel = 'Отсканировано:';
  static const invoiceSendDataButton = 'ОТПРАВИТЬ В F3TAIL';
  static const invoiceSendDataInProgressButton = 'ОТПРАВЛЯЕМ ДАННЫЕ...';
  static const invoiceSendDataCompletedMessage = 'Данные успешно отправлены.';
  static const invoiceSendDataErrorMessage =
      'При отправке данных произошла ошибка.';
  static const fileSendDataCompletedMessage = 'Данные успешно сохранены.';
  static const fileSendDataErrorMessage =
      'При отправке данных произошла ошибка.';

  static const inventoryVedLoadingDataMessage = 'Загружаем позиции...';
  static const inventoryVedLoadingDataErrorMessage =
      'При загрузке инвентаризации произошла ошибка.';

  static const invoiceItemKizPageName = 'Список КИЗ';
  static const invoiceItemKizSelectAllLabel = 'Выбрать все';
  static const invoiceItemKizPageButtonAdd = 'ДОБАВИТЬ';
  static const invoiceItemKizPageButtonDelete = 'УДАЛИТЬ';

  static const invoiceItemScanPageName = 'Серия';
  static const invoiceItemScanButtonComplete = 'ЗАВЕРШИТЬ';

  static const startPageInstruction = [
    'Откройте в F3 Tail модуль Фармадата, раздел "Сервисы" или распечатайте полученный вместе с лицензией QR-код.',
    'Нажмите "НАЧАТЬ РАБОТУ" и отсканируйте полученный QR-код.',
    'Если у Вас возникли сложности при лицензировании свяжитесь с нами.'
  ];
  static const InvoicePageInstruction = [
    'На главной странице собраны разделы с документами F3 Tail. Документы должны быть в статусе "Сохранен"',
    'Сканируйте КИЗ для позиции документа, количество штрихкодов соответствует количеству упаковок.',
    'После завершения сканирования будет доступна кнопка "Отправить в F3 Tail".',
    'Отправить можно часть позиций накладной, все результаты будут сохранены.',
    'Отработайте документ в F3 Tail.'
  ];

  static const InvPageInstruction = [
    'На главной странице собраны разделы с Инвентаризационными вед-тями. Документы должны быть в статусе "Сохранен"',
    'Сканируйте КИЗ, которые планируете добавить в ведомость',
    'После завершения сканирования - долго зажмите карточку ведомости, будет доступна кнопка "Отправить в F3 Tail"',
    'Отправить можно и часть позиций, все результаты будут сохранены',
    'Отработайте документ в сводной ведомости F3 Tail.'
  ];

  static const ChequePageInstruction = [
    'На этой странице можно сканировать КИЗ и передавать их в F3Tail"',
    '"Чек" может содержать неограниченнное число КИЗ',
    'После завершения смены нажмите кнопку "Отправить',
    'Отправить можно всю смену или часть',
    'Отработайте документ "Отложенный чек" в F3 Tail.'
  ];
  static const startPageStartButton = 'НАЧАТЬ РАБОТУ';
  static const startInstructionButton = 'УЗНАТЬ КАК ПОЛУЧИТЬ QR-КОД';

  static const error = 'Ошибка';
  static const unknownError = 'Ошибка';

  static const noInternet =
      'Похоже, отсутствует интернет или сервер недоступен.';
  static const loading = 'Загрузка данных...';

  static const licenseUpdating = 'Получение данных о лицензии...';
  static const licenseChecking = 'Проверяем лицензию...';
  static const licenseNotFound = 'Лицензия не найдена.';
  static const licenseShouldBePurchased =
      'Для использования этого модуля приобретите лицензию.';
  static const licenseCouldNotBeRefreshed = 'Не удалось обновить лицензию.';

  static const deleteLicenseInfo = 'ОТКАЗАТЬСЯ ОТ ИСПОЛЬЗОВАНИЯ';
  static const exitLicensePage = 'ЗАКРЫТЬ';

  static const registerPageInstruction = [
    'Для доступа к данным аптеки требуется регистрация телефона.',
    'Номер Вашего устройства отправлен для регистрации в ПО F3Tail',
    'Привяжите пользователя F3 Tail к ИД телефона (Системные контанты->Регистрация)'
  ];
  static const getLicInctruction = [
    'Оставить заявку можно по телeфону 8-800-700-47-08',
    'Заявку также можно отправить на почту info@spargo.ru',
    'Заявку можно оставить в Telegram боте.',
  ];
  static const getDLInctruction = [
    'Если у Вас установлен модуль Фармадата - откройте раздел "Сервисы" и нажмите на кнопку F3 Mobile',
    'Если модуль Фармадата не установлен - скачайте и установите его  на компьютер с установленным F3 Tail по ссылке с официального сайта',
  ];

  static const registerButton = 'ПРОВЕРИТЬ';
  static const closeInstructionPermanently = 'ЗАКРЫТЬ И НЕ ПОКАЗЫВАТЬ';
  static const closeInstruction = 'ЗАКРЫТЬ';
  static const newCheque = 'НОВЫЙ ЧЕК';
  static const saveCheque = 'СОХРАНИТЬ ЧЕК';
}

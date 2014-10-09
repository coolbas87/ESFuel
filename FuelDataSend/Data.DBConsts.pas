{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2010 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBConsts;

interface

resourcestring
  SInvalidFieldSize = 'Невірний розмір поля';
  SInvalidFieldKind = 'Невірний FieldKind';
  SInvalidFieldRegistration = 'Невірна реєстрація поля';
  SUnknownFieldType = 'Тип поля "%s" невідомий';
  SFieldNameMissing = 'Відсутнє ім''я поля';
  SDuplicateFieldName = 'Дублікат імені поля "%s"';
  SFieldNotFound = 'Поле "%s" не знайдено';
  SFieldAccessError = 'Не вдається одержати доступ до поля "%s" як типу %s';
  SFieldValueError = 'Невірне значення для поля "%s"';
  SFieldRangeError = '"%g" - невірне значення для поля "%s". Дозволений діапазон - від %g до %g';
  SBcdFieldRangeError = '"%s" - невірне значення для поля "%s". Дозволений діапазон - від %s до %s';
  SInvalidIntegerValue = '"%s" - невірне ціле значення для поля "%s"';
  SInvalidBoolValue = '"%s" - невірне логічне значення для поля "%s"';
  SInvalidFloatValue = '"%s" - невірне дробове значення для поля "%s"';
  SFieldTypeMismatch = 'Невірний тип поля "%s", очікується: %s, встановлено: %s';
  SFieldSizeMismatch = 'Невірний розмір для поля "%s", очікується: %d, встановлено: %d';
  SInvalidVarByteArray = 'Невірний варіантний тип або розмір поля "%s"';
  SFieldOutOfRange = 'Значення поля "%s" вийшло за межі';
//  SBCDOverflow = '(Переповнення)';
  SCantAdjustPrecision = 'Помилка встановлення точністі BCD';
  SFieldRequired = 'Поле "%s" повинне мати значення';
  SDataSetMissing = 'Поле "%s" не має набору даних (dataset)';
  SInvalidCalcType = 'Поле "%s" не може бути обчислюваним або пошуковим полем';
  SFieldReadOnly = 'Поле "%s" не може бути змінене';
  SFieldIndexError = 'Індекс поля вийшов за межі';
  SNoFieldIndexes = 'Немає активного індексу';
  SNotIndexField = 'Поле "%s" не індексовано і не може бути змінене';
  SIndexFieldMissing = 'Не вдається одержати доступ до індексного поля "%s"';
  SDuplicateIndexName = 'Дублікат імені індексу "%s"';
  SNoIndexForFields = 'Немає індексу для полів "%s"';
  SIndexNotFound = 'Індекс "%s" не знайдено';
  SDBDuplicateName = 'Дублікат імени "%s" в %s';
  SCircularDataLink = 'Циклічні зв''язки даних не дозволені';
  SLookupInfoError = 'Інформація пошуку (lookup) для поля "%s" - неповна';
  SNewLookupFieldCaption = 'Нове пошукове (lookup) поле';
  SDataSourceChange = 'DataSource не може бути змінений';
  SNoNestedMasterSource = 'Вкладені таблиці не можуть мати MasterSource';
  SDataSetOpen = 'Не вдається виконати цю операцію для відкритого набору даних (dataset)';
  SNotEditing = 'Набір даних (Dataset) не в режимі редагування або вставки';
  SDataSetClosed = 'Не вдається виконати цю операцію для закритого набору даних (dataset)';
  SDataSetEmpty = 'Не вдається виконати цю операцію для порожнього набору даних (dataset)';
  SDataSetReadOnly = 'Не дозволяється змінювати набір даних "тільки для читання" (read-only dataset)';
  SNestedDataSetClass = 'Вкладений набір даних повинний успадковуватися від %s';
  SExprTermination = 'Вираження фільтра некоректно завершене';
  SExprNameError = 'Незавершене ім''я поля';
  SExprStringError = 'Незавершена строкова константа';
  SExprInvalidChar = 'Невірний символ у виразі фільтра: "%s"';
  SExprNoLParen = 'Очікується "(", але виявлено %s';
  SExprNoRParen = 'Очікується ")", але виявлено %s';
  SExprNoRParenOrComma = 'Очікується ")" або ",", але виявлено %s';
  SExprExpected = 'Очікується вираз, але виявлено %s';
  SExprBadField = 'Поле "%s" не може використовуватись у виразі фільтру';
  SExprBadNullTest = 'NULL дозволено лише з "=" та "<>"';
  SExprRangeError = 'Константа вийшла за межі';
  SExprNotBoolean = 'Поле "%s" - не логічного типу';
  SExprIncorrect = 'Некоректно сформований вираз фільтру';
  SExprNothing = 'Пусто';
  SExprTypeMis = 'Неспівпадіння типів у виразі';
  SExprBadScope = 'В операції не можна змішувати агрегатні значення зі значеннями полів';
  SExprNoArith = 'Арифметика у виразі фільтру не підтримується';
  SExprNotAgg = 'Вираз не є агрегатним';
  SExprBadConst = 'Константа невірного типу %s';
  SExprNoAggFilter = 'Агрегатні вирази не підтримуються в фільтрах';
  SExprEmptyInList = 'Список IN команди не може бути пустим';
  SInvalidKeywordUse = 'Невірне використання ключового слова';
  STextFalse = 'False';
  STextTrue = 'True';
  SParameterNotFound = 'Параметр "%s" не знайдено';
  SInvalidVersion = 'Неможливо завантажити параметри прив''язки';
  SParamTooBig = 'Параметр "%s", не можна зберегти дані довше %d байт';
  SBadFieldType = 'Тип поля "%s" не підтримується';
  SAggActive = 'Властивість не може бути змінена, поки aggregate активне';
  SProviderSQLNotSupported = 'SQL не підтримується: %s';
  SProviderExecuteNotSupported = 'Виконання не підтримується: %s';
  SExprNoAggOnCalcs = 'Поле "%s" невірного типу для обчислюваних полів в aggregate, використовуйте internalcalc';
  SRecordChanged = 'Запис змінений іншим користувачем';
  SDataSetUnidirectional = 'Операція не допускається на односпрямованому наборі даних (dataset)';
  SUnassignedVar = 'Unassigned значення варіанту';
  SRecordNotFound = 'Запис не знайдено';
  SFileNameBlank = 'Властивість FileName не може бути порожньою';
  SFieldNameTooLarge = 'Ім''я поля %s перебільшило %d символів';

{ For FMTBcd }

  SBcdOverflow = 'Переповнення BCD';
  SInvalidBcdValue = '%s - невірне BCD значення';
  SInvalidFormatType = 'Невірний тип формату для BCD';

{ For SqlTimSt }

  SCouldNotParseTimeStamp = 'Не вдається розібрати SQL TimeStamp строку';
  SInvalidSqlTimeStamp = 'Невірні значення SQL дати/часу';
  SCalendarTimeCannotBeRepresented = 'Неможливо відобразити календарний час';

  SDeleteRecordQuestion = 'Видалити запис?';
  SDeleteMultipleRecordsQuestion = 'Видалити всі обрані записи?';
  STooManyColumns = 'Таблиця (Grid) не може містити більш 256 колонок';

  { For reconcile error }
  SSkip = 'Пропустити';
  SAbort = 'Перервати';
  SMerge = 'Об''днати';
  SCorrect = 'Correct';
  SCancel  = 'Відміна';
  SRefresh = 'Поновити';
  SModified = 'Змінено';
  SInserted = 'Вставлено';
  SDeleted  = 'Вилучено';
  SCaption = 'Помилка змінення - %s';
  SUnchanged = '<Не змінено>';  
  SBinary = '(Двоичний)';                              
  SAdt = '(ADT)';   
  SArray = '(Масив)'; 
  SFieldName = 'Им''я поля'; 
  SOriginal = 'Вихідне значення'; 
  SConflict = 'Конфліктуюче значення';  
  SValue = ' Значення';   
  SNoData = '<Немає записів>';
  SNew = 'Нов.';    

implementation

end.

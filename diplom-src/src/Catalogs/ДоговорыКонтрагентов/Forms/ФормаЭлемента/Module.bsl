//Доработка++
#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	НоваяГруппаФормыПериод = Элементы.Добавить("ПериодДействия", Тип("ГруппаФормы"));
    НоваяГруппаФормыПериод.Вид                 = ВидГруппыФормы.ОбычнаяГруппа;
    НоваяГруппаФормыПериод.Отображение         = ОтображениеОбычнойГруппы.Нет;
    НоваяГруппаФормыПериод.ОтображатьЗаголовок = Ложь;
    НоваяГруппаФормыПериод.Группировка         = ГруппировкаПодчиненныхЭлементовФормы.Горизонтальная;
    
    НоваяГруппаФормыСтоимость = Элементы.Добавить("Стоимость", Тип("ГруппаФормы"));
    НоваяГруппаФормыСтоимость.Вид                 = ВидГруппыФормы.ОбычнаяГруппа;
    НоваяГруппаФормыСтоимость.Отображение         = ОтображениеОбычнойГруппы.Нет;
    НоваяГруппаФормыСтоимость.ОтображатьЗаголовок = Ложь;
    НоваяГруппаФормыСтоимость.Группировка         = ГруппировкаПодчиненныхЭлементовФормы.Горизонтальная;
    
    НовыйЭлемент = Элементы.Добавить("ДатаНачалаДействия", Тип("ПолеФормы"), НоваяГруппаФормыПериод);
    НовыйЭлемент.ПутьКДанным    = "Объект.ВКМ_ДатаНачалаДействия";
    НовыйЭлемент.Вид            = ВидПоляФормы.ПолеВвода;
    НовыйЭлемент.Видимость = Ложь;
     
    НовыйЭлемент = Элементы.Добавить("ДатаОкончанияДействия", Тип("ПолеФормы"), НоваяГруппаФормыПериод);
    НовыйЭлемент.ПутьКДанным    = "Объект.ВКМ_ДатаОкончанияДействия";
    НовыйЭлемент.Вид            = ВидПоляФормы.ПолеВвода;
    НовыйЭлемент.Видимость = Ложь;
       
    НовыйЭлемент = Элементы.Добавить("АбонентскаяПлата", Тип("ПолеФормы"), НоваяГруппаФормыСтоимость);
    НовыйЭлемент.ПутьКДанным    = "Объект.ВКМ_АбонентскаяПлата";
    НовыйЭлемент.Вид            = ВидПоляФормы.ПолеВвода;
    НовыйЭлемент.Видимость = Ложь;
   
    НовыйЭлемент = Элементы.Добавить("СтоимостьЧаса", Тип("ПолеФормы"), НоваяГруппаФормыСтоимость);
    НовыйЭлемент.ПутьКДанным    = "Объект.ВКМ_СтоимостьЧаса";
    НовыйЭлемент.Вид            = ВидПоляФормы.ПолеВвода;
    НовыйЭлемент.Видимость = Ложь;
    
	Если Объект.ВидДоговора = Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание Тогда
		Элементы.ДатаНачалаДействия.Видимость = Истина;
		Элементы.ДатаОкончанияДействия.Видимость = Истина;
		Элементы.АбонентскаяПлата.Видимость = Истина;
		Элементы.СтоимостьЧаса.Видимость = Истина;	
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы
&НаКлиенте
Процедура ВидДоговораПриИзменении(Элемент)
	ВидДоговораПриИзмененииНаСервере();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ВидДоговораПриИзмененииНаСервере()
	Если Объект.ВидДоговора = Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание Тогда
		Элементы.ДатаНачалаДействия.Видимость = Истина;
		Элементы.ДатаОкончанияДействия.Видимость = Истина;
		Элементы.АбонентскаяПлата.Видимость = Истина;
		Элементы.СтоимостьЧаса.Видимость = Истина;	
	Иначе
		Элементы.ДатаНачалаДействия.Видимость = Ложь;
		Элементы.ДатаОкончанияДействия.Видимость = Ложь;
		Элементы.АбонентскаяПлата.Видимость = Ложь;
		Элементы.СтоимостьЧаса.Видимость = Ложь;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти
//Доработка--
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка) 
	
	Отпуска = ПолучитьИзВременногоХранилища(Параметры.АдресХранилища); 
	
	ДиаграммаГанта.Очистить(); 
	ДиаграммаГанта.Обновление = Ложь;
	
	Для Каждого Элемент Из Отпуска Цикл
		Точка = ДиаграммаГанта.УстановитьТочку(Элемент.Сотрудник);	
		Серия = ДиаграммаГанта.УстановитьСерию("Отпуск"); 	
		Значение = ДиаграммаГанта.ПолучитьЗначение(Точка, Серия); 
		Интервал = Значение.Добавить();
		Интервал.Начало = Элемент.ДатаНачала;
		Интервал.Конец = Элемент.ДатаОкончания; 	
	КонецЦикла;
	
	ДиаграммаГанта.Обновление = Истина;
	
КонецПроцедуры

#КонецОбласти
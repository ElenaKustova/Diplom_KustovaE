#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

// Заполнить график.
// 
// Параметры:
//  ДатаНачала - Дата - Дата начала
//  ДатаОкончания - Дата - Дата окончания
//  ВыходныеДни - Число - Выходные дни
//  ГрафикРаботы - Строка - График работы
Процедура ЗаполнитьГрафик(ДатаНачала, ДатаОкончания, ВыходныеДни, ГрафикРаботы) Экспорт 
	
	Набор = РегистрыСведений.ВКМ_ГрафикиРаботы.СоздатьНаборЗаписей();
	
	Набор.Отбор.ГрафикРаботы.Установить(ГрафикРаботы);
	
	Набор.Прочитать();
	
	ЧислоСекундВСутках = 86400;
	
	Дат = ДатаНачала;
	Для к = 0 По Набор.Количество()-1 Цикл
		
		Запись = Набор[к];
		Если Запись.Дата < ДатаНачала Тогда
		    Продолжить;
		ИначеЕсли Запись.Дата =Дат Тогда
			//@skip-check use-non-recommended-method
			Если Найти(ВыходныеДни, Строка(ДеньНедели(Дат))) Тогда
				Запись.Значение = 0;
			Иначе	          
				Запись.Значение = 8;
			КонецЕсли;
			Дат = Дат + ЧислоСекундВСутках;
		Иначе
			Пока Дат < Мин(Запись.Дата, ДатаОкончания) Цикл
				НоваяЗапись = Набор.Добавить();
			    //@skip-check wrong-type-expression
			    НоваяЗапись.ГрафикРаботы = ГрафикРаботы;
				НоваяЗапись.Дата = Дат;
				//@skip-check use-non-recommended-method
				Если Найти(ВыходныеДни, Строка(ДеньНедели(Дат))) Тогда
					НоваяЗапись.Значение = 0;
				Иначе	          
					НоваяЗапись.Значение = 8;
				КонецЕсли; 
				Дат = Дат + ЧислоСекундВСутках;
			КонецЦикла; 
			Если Запись.Дата > ДатаОкончания Тогда
				Прервать;
			Иначе
				//@skip-check use-non-recommended-method
				Если Найти(ВыходныеДни, Строка(ДеньНедели(Дат))) Тогда
					Запись.Значение = 0;
				Иначе	          
					Запись.Значение = 8;
				КонецЕсли;
			КонецЕсли;
			Дат = Дат + ЧислоСекундВСутках;
		КонецЕсли; 
	КонецЦикла;
	Набор.Записать();
	
	Пока Дат <= ДатаОкончания Цикл
		Запись = Набор.Добавить();
		//@skip-check wrong-type-expression
		Запись.ГрафикРаботы = ГрафикРаботы;
		Запись.Дата = Дат;
		//@skip-check use-non-recommended-method
		Если Найти(ВыходныеДни, Строка(ДеньНедели(Дат))) Тогда
			Запись.Значение = 0;
		Иначе	          
			Запись.Значение = 8;
		КонецЕсли; 
		Дат = Дат + ЧислоСекундВСутках;
	КонецЦикла; 
	Набор.Записать();
КонецПроцедуры

#КонецОбласти

#КонецЕсли

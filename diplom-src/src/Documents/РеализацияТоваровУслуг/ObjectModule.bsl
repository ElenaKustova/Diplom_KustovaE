
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Ответственный = Пользователи.ТекущийПользователь();
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ЗаказПокупателя") Тогда
		ЗаполнитьНаОснованииЗаказаПокупателя(ДанныеЗаполнения); 
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	СуммаДокумента = Товары.Итог("Сумма") + Услуги.Итог("Сумма");
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)

	Движения.ОбработкаЗаказов.Записывать = Истина;
	Движения.ОстаткиТоваров.Записывать = Истина;
	
	Движение = Движения.ОбработкаЗаказов.Добавить();
	Движение.Период = Дата;
	Движение.Контрагент = Контрагент;
	Движение.Договор = Договор;
	Движение.Заказ = Основание;
	Движение.СуммаОтгрузки = СуммаДокумента;

	Для Каждого ТекСтрокаТовары Из Товары Цикл
		Движение = Движения.ОстаткиТоваров.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Контрагент = Контрагент;
		Движение.Номенклатура = ТекСтрокаТовары.Номенклатура;
		Движение.Сумма = ТекСтрокаТовары.Сумма;
		Движение.Количество = ТекСтрокаТовары.Количество;
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьНаОснованииЗаказаПокупателя(ДанныеЗаполнения)
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ЗаказПокупателя.Организация КАК Организация,
	               |	ЗаказПокупателя.Контрагент КАК Контрагент,
	               |	ЗаказПокупателя.Договор КАК Договор,
	               |	ЗаказПокупателя.СуммаДокумента КАК СуммаДокумента,
	               |	ЗаказПокупателя.Товары.(
	               |		Ссылка КАК Ссылка,
	               |		НомерСтроки КАК НомерСтроки,
	               |		Номенклатура КАК Номенклатура,
	               |		Количество КАК Количество,
	               |		Цена КАК Цена,
	               |		Сумма КАК Сумма
	               |	) КАК Товары,
	               |	ЗаказПокупателя.Услуги.(
	               |		Ссылка КАК Ссылка,
	               |		НомерСтроки КАК НомерСтроки,
	               |		Номенклатура КАК Номенклатура,
	               |		Количество КАК Количество,
	               |		Цена КАК Цена,
	               |		Сумма КАК Сумма
	               |	) КАК Услуги
	               |ИЗ
	               |	Документ.ЗаказПокупателя КАК ЗаказПокупателя
	               |ГДЕ
	               |	ЗаказПокупателя.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", ДанныеЗаполнения);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Не Выборка.Следующий() Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Выборка);
	
	ТоварыОснования = Выборка.Товары.Выбрать();
	Пока ТоварыОснования.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Товары.Добавить(), ТоварыОснования);
	КонецЦикла;
	
	УслугиОснования = Выборка.Услуги.Выбрать();
	Пока ТоварыОснования.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Услуги.Добавить(), УслугиОснования);
	КонецЦикла;
	
	Основание = ДанныеЗаполнения;
	
КонецПроцедуры

//Доработка++
// ВКМ выполнить автозаполнение.
Процедура ВКМ_ВыполнитьАвтозаполнение() Экспорт
	
	НоменклатураАбонентскаяПлата = Константы.ВКМ_НоменклатураАбонентскаяПлата.Получить();
	НоменклатураРаботыСпециалиста = Константы.ВКМ_НоменклатураРаботыСпециалиста.Получить();
	
	Если НЕ ЗначениеЗаполнено(НоменклатураАбонентскаяПлата)	ИЛИ НЕ ЗначениеЗаполнено(НоменклатураРаботыСпециалиста)	Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Не заполнены константы";
		Сообщение.Сообщить();
		Возврат;
	КонецЕсли;
	
	Товары.Очистить();
	Услуги.Очистить();
		
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ЕСТЬNULL(ДоговорыКонтрагентов.ВКМ_АбонентскаяПлата, 0) КАК АбонентскаяПлата,
		|	ЕСТЬNULL(ВКМ_ВыполненныеКлиентуРаботыОбороты.КоличествоЧасовОборот, 0) КАК КоличествоЧасов,
		|	ЕСТЬNULL(ВКМ_ВыполненныеКлиентуРаботыОбороты.СуммаКОплатеОборот, 0) КАК СуммаКОплате
		|ИЗ
		|	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ВКМ_ВыполненныеКлиентуРаботы.Обороты(&ДатаНачала, &ДатаОкончания, Месяц, ) КАК ВКМ_ВыполненныеКлиентуРаботыОбороты
		|		ПО ДоговорыКонтрагентов.Ссылка = ВКМ_ВыполненныеКлиентуРаботыОбороты.Договор
		|			И ДоговорыКонтрагентов.Владелец = ВКМ_ВыполненныеКлиентуРаботыОбороты.Клиент
		|ГДЕ
		|	ДоговорыКонтрагентов.Ссылка = &Договор";
	
	Запрос.УстановитьПараметр("Договор", Договор);
	Запрос.УстановитьПараметр("ДатаНачала", НачалоМесяца(Дата));
	Запрос.УстановитьПараметр("ДатаОкончания", КонецМесяца(Дата));
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		НоваяСтрока = Услуги.Добавить(); 
        НоваяСтрока.Номенклатура = Справочники.Номенклатура.НайтиПоНаименованию(НоменклатураАбонентскаяПлата);
        НоваяСтрока.Сумма = Выборка.АбонентскаяПлата;
        Если Выборка.СуммаКОплате <> 0 Тогда
        	НоваяСтрока = Услуги.Добавить(); 
        	НоваяСтрока.Номенклатура = Справочники.Номенклатура.НайтиПоНаименованию(НоменклатураРаботыСпециалиста);
        	НоваяСтрока.Количество = Выборка.КоличествоЧасов;
        	НоваяСтрока.Сумма = Выборка.СуммаКОплате;
        КонецЕсли;
        Основание = Договор; 	
	КонецЦикла;
	
КонецПроцедуры

//Доработка--

#КонецОбласти

#КонецЕсли

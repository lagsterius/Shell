::Отключить вывод команд на экран
@Echo off

::Включение отложенного расширения переменной среды
Setlocal EnableDelayedExpansion

::Путь к папке со всеми записями
Set CurDir=E:\TRManager\VoiceData

::Выделение из даты текущего года
Set CurYear=%DATE:~-4%
::Выделение из даты текущего месяца
Set CurMonth=%DATE:~3,2%
::Выделение из даты текущего дня
Set CurDay=%DATE:~0,2%
::Формирования даты в формате YYYYMMDD. Такой вид записи папок системой Telest
Set CurDate=%CurYear%%CurMonth%%CurDay%

::Полный путь к папке с сегодняшними записями
Set CurFullDir=%CurDir%\%CurDate%

::Текст письма
Set CurBody=""

::Общее число сегодняшних записей
Set /a CurN=0
::Число сегодняшних записей потока BEELINE
Set /a CurB=0
::Число сегодняшних записей потока MANAGER
Set /a CurM=0

::Время и имена самых свежих записей B - Beeline, M - Manager, N - Name, T - Time
Set CurBN=""
Set CurBT=""
Set CurMN=""
Set CurMT=""

::Адресаты рассылки
Set CurTo=mao@kolbasa.ru,ahaev.nb@kolbasa.ru,kamachkin.rf@kolbasa.ru,rn.latypov@kolbasa.ru,aa.savkin@kolbasa.ru

::Путь к программе отправки сообщений, указание адресата, кодировки и темы письма
Set CurBlat=c:\blat\blat.exe -charset utf-8 -to %CurTo% -subject "Запись разговоров Telest" -body

::Проверка существования папки с сегодняшними записями и самими записями сегодняшних разговоров и формирование текста письма
If Exist %CurFullDir%\* (
	If Exist %CurFullDir%\B* (
		If Exist %CurFullDir%\M* (
			Set CurBody="Запись разговоров сегодня ведется в полном объеме с обоих потоков"
		) else (
			Set CurBody="Сегодня нет записей потока MANAGER, обратите на это внимание ^(отсутствие записей до 8 утра является нормой^)")
	) else (
		If Exist %CurFullDir%\M* (
			Set CurBody="Сегодня нет записей потока BEELINE, обратите на это внимание"          
		) else (
			Set CurBody="Сегодня оба потока не пишутся, обратите на это внимание"))
) else (	
	Set CurBody="Папки с сегодняшней датой не существует")

::Подсчет общего числа сегодняшних записей	
for %%i in (%CurFullDir%\*) do Set /a CurN=%CurN+1
::Подсчет числа сегодняшних записей потока BEELINE
for %%i in (%CurFullDir%\B*) do Set /a CurB=%CurB+1
::Подсчет числа сегодняшних записей потока MANAGER
for %%i in (%CurFullDir%\M*) do Set /a CurM=%CurM+1

::Формирование текста письма
Set CurBody=%CurBody:~0,-1%. Всего записей - %CurN%
Set CurBody=%CurBody%. Количество записей BEELINE - %CurB%
Set CurBody=%CurBody%. Количество записей MANAGER - %CurM%

::Формирование текста письма
If exist %CurFullDir%\B* (
	for /f "tokens=2,3*" %%a in ('dir/a-d/od/tc/-c %CurFullDir%\B*^|findstr/rc:"^[^ ]"') do set "BN=%%c"& set "BT=%%a"
	Set CurBody=%CurBody%. Последняя запись BEELINE - '!BN!' в !BT!
)
If exist %CurFullDir%\M* (
	for /f "tokens=2,3*" %%a in ('dir/a-d/od/tc/-c %CurFullDir%\M*^|findstr/rc:"^[^ ]"') do set "MN=%%c"& set "MT=%%a"
	Set CurBody=%CurBody%. Последняя запись MANAGER - '!MN!' в !MT!
)

::Формирование текста письма
Set CurBody=%CurBody%."

::Отправка письма
%CurBlat% %CurBody%
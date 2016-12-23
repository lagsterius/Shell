::�⪫���� �뢮� ������ �� �࠭
@Echo off

::����祭�� �⫮������� ���७�� ��६����� �।�
Setlocal EnableDelayedExpansion

::���� � ����� � �ᥬ� �����ﬨ
Set CurDir=E:\TRManager\VoiceData

::�뤥����� �� ���� ⥪�饣� ����
Set CurYear=%DATE:~-4%
::�뤥����� �� ���� ⥪�饣� �����
Set CurMonth=%DATE:~3,2%
::�뤥����� �� ���� ⥪�饣� ���
Set CurDay=%DATE:~0,2%
::��ନ஢���� ���� � �ଠ� YYYYMMDD. ����� ��� ����� ����� ��⥬�� Telest
Set CurDate=%CurYear%%CurMonth%%CurDay%

::����� ���� � ����� � ᥣ����譨�� �����ﬨ
Set CurFullDir=%CurDir%\%CurDate%

::����� ���쬠
Set CurBody=""

::��饥 �᫮ ᥣ����譨� ����ᥩ
Set /a CurN=0
::��᫮ ᥣ����譨� ����ᥩ ��⮪� BEELINE
Set /a CurB=0
::��᫮ ᥣ����譨� ����ᥩ ��⮪� MANAGER
Set /a CurM=0

::�६� � ����� ᠬ�� ᢥ��� ����ᥩ B - Beeline, M - Manager, N - Name, T - Time
Set CurBN=""
Set CurBT=""
Set CurMN=""
Set CurMT=""

::������ ���뫪�
Set CurTo=mao@kolbasa.ru,ahaev.nb@kolbasa.ru,kamachkin.rf@kolbasa.ru,rn.latypov@kolbasa.ru,aa.savkin@kolbasa.ru

::���� � �ணࠬ�� ��ࠢ�� ᮮ�饭��, 㪠����� �����, ����஢�� � ⥬� ���쬠
Set CurBlat=c:\blat\blat.exe -charset utf-8 -to %CurTo% -subject "������ ࠧ����஢ Telest" -body

::�஢�ઠ ����⢮����� ����� � ᥣ����譨�� �����ﬨ � ᠬ��� �����ﬨ ᥣ����譨� ࠧ����஢ � �ନ஢���� ⥪�� ���쬠
If Exist %CurFullDir%\* (
	If Exist %CurFullDir%\B* (
		If Exist %CurFullDir%\M* (
			Set CurBody="������ ࠧ����஢ ᥣ���� ������� � ������ ��ꥬ� � ����� ��⮪��"
		) else (
			Set CurBody="������� ��� ����ᥩ ��⮪� MANAGER, ����� �� �� �������� ^(������⢨� ����ᥩ �� 8 ��� ���� ��ମ�^)")
	) else (
		If Exist %CurFullDir%\M* (
			Set CurBody="������� ��� ����ᥩ ��⮪� BEELINE, ����� �� �� ��������"          
		) else (
			Set CurBody="������� ��� ��⮪� �� �������, ����� �� �� ��������"))
) else (	
	Set CurBody="����� � ᥣ����譥� ��⮩ �� �������")

::������ ��饣� �᫠ ᥣ����譨� ����ᥩ	
for %%i in (%CurFullDir%\*) do Set /a CurN=%CurN+1
::������ �᫠ ᥣ����譨� ����ᥩ ��⮪� BEELINE
for %%i in (%CurFullDir%\B*) do Set /a CurB=%CurB+1
::������ �᫠ ᥣ����譨� ����ᥩ ��⮪� MANAGER
for %%i in (%CurFullDir%\M*) do Set /a CurM=%CurM+1

::��ନ஢���� ⥪�� ���쬠
Set CurBody=%CurBody:~0,-1%. �ᥣ� ����ᥩ - %CurN%
Set CurBody=%CurBody%. ������⢮ ����ᥩ BEELINE - %CurB%
Set CurBody=%CurBody%. ������⢮ ����ᥩ MANAGER - %CurM%

::��ନ஢���� ⥪�� ���쬠
If exist %CurFullDir%\B* (
	for /f "tokens=2,3*" %%a in ('dir/a-d/od/tc/-c %CurFullDir%\B*^|findstr/rc:"^[^ ]"') do set "BN=%%c"& set "BT=%%a"
	Set CurBody=%CurBody%. ��᫥���� ������ BEELINE - '!BN!' � !BT!
)
If exist %CurFullDir%\M* (
	for /f "tokens=2,3*" %%a in ('dir/a-d/od/tc/-c %CurFullDir%\M*^|findstr/rc:"^[^ ]"') do set "MN=%%c"& set "MT=%%a"
	Set CurBody=%CurBody%. ��᫥���� ������ MANAGER - '!MN!' � !MT!
)

::��ନ஢���� ⥪�� ���쬠
Set CurBody=%CurBody%."

::��ࠢ�� ���쬠
%CurBlat% %CurBody%
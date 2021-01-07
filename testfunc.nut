//Отдельный скрипт для моих функций в лаунчере
//-----------Параметры--------------
//ШИЗА
//ЕСЛИ ЭТО СОХРАНИЛОСЬ ТО СОХРАНЕНИЕ РАБОТАЕТ

//версия моей модификации
::modVersion <- "1.3.1"
::modDate <- "18 ноября 2020"
::online_version <- "p1"
::license_test <- "license.key"
::server_monitoring_closed <- true
::secret_settings_closed <- true
::paused <- false
::exit_after_download <- false
::isDownloading <- "0";
::alreadyActivated <- false
::customize_menu_closed <- true;

//-----------Параметры--------------

//-----------Для чита-----------
function getCheatPath() {return ::makeFullPath(::getGameDir(), "CrossoutRevenge.exe");}
function showCheatButton() {
	if( ::fileExists( ::makeFullPath( ::getGameDir(), "CrossoutRevenge.exe")))
		::display("cheat_button", true);
}
function runCheat() {
	local parameters = ""
	::shellExecute(::getCheatPath(), parameters, ::getGameDir(), ::SW_SHOWNORMAL)
	::save_and_exit();
}
//-----------Для чита-----------

function clicker_test() {
  local clicked = ::getValue("clickerCount");
  while(true) {
    if(::questMessageUtf("Накликано " + clicked + " раз", ""))
      clicked += 1
    else {
      ::setValue("clickerCount", clicked);
      return;
    }
  }
}
function changeCursor() {
  ::setStyleAttribute("body", "cursor", "url( img/pisos.cur )");
}
function HideToTray() {
  ::minimizeToTray();
  ::setTrayIconTooltip(::getLocText( "header" ));
  if(::exit_after_download) {
    ::displayTrayBalloon(::getLocText( "header" ), ::getLocText("tray_download"));
  }
  else
    ::displayTrayBalloon(::getLocText( "header" ), ::getLocText("tray_not_closed"));
}
function openCustomSettings() {
  if(::customize_menu_closed) {
    ::display( "settings_dialog_4", true )
    ::display( "settings_dialog", false )
    ::display( "settings_dialog_2", false )
    ::customize_menu_closed = false;
	::display("customcolor1s", true);
  } else {
    ::display("settings_dialog_4", false);
    ::customize_menu_closed = true;
    ::display("settings_dialog_5", false);
	::display("settings_dialog_7", false);
	::display("customcolor1s", true);
  }
  ::display("close_customize_button", !::customize_menu_closed);
  ::display("open_customize_button", ::customize_menu_closed);
}

function addCustomOptions() {
  ::display("settings_dialog_5", true);
}
function addColorOptions() {
  ::display("settings_dialog_7", true);
}
function disable_exitAfterDownload() {::exit_after_download = false;}

function info_buttonClick() {
  ::infoMessageUtf(::getLocText( "header" ) + " " + ::modVersion + " (" + ::modDate + ")" + "\nРазработчик: B3PblBHOU_KOT, Mod - BeKotIK \n-Менюшка с параметрами запуска\n-Новости можно скроллить (+ 2-3 скрытых новости)\n-Управление загрузкой\n-Только русский язык\n-Меню кастомизации! настраивайте лаунчер как хотите\n Открыта менюшка с версиями серверами (но кот не обновляет ее) \n Теперь можно скачивать клиенты разрабов \n Можно сбрасывать рекорд в кликере \n Функция запуск без античита \n Открыта менюшка с выбором сервера", ::getLocText( "header" ));
}
function credits() {
  ::infoMessageUtf("Разработчик: B3PblBHOU_KOT" + "\nВерсия лаунчера: " + ::modVersion +  "\nВерсия игры: " + ::getLocalGameVersion(::getGameDir() , ::yupProject) + " (" + curCircuit + ")", "Инфо:");
  ::executeFromLauncherTest();
}
function hideForMaber() {
  ::display("circuitParam_block", true);
  ::display("no_eac_block", true);
  ::display("server_button", true);
  ::display("server_img", true);
  ::display("myLogo_button", true);
  ::display("myLogo_img", true); 
}
function getVersionsByTable() {
  local server_table = ::getHtml("server_table");
  local live = ::getHtml("live_version");
  local ptr = ::getHtml("ptr_version");
  local staging = ::getHtml("staging_version");
  local futura= ::getHtml("futura_version");
  local pr_test = ::getHtml("pr_test_version");

  if(server_table == "")
    ::infoMessageUtf("Не удалось загрузить таблицу\n(нет подключения к интернету?)", "Версии с таблицы");
  else
    ::infoMessageUtf("live: " + live + "\nptr: " + ptr + "\nstaging: " + staging + "\nfutura: " + futura + "\npr_test: " + pr_test, "Версии с таблицы");
}
function onServerParserReady1( html )
{
  ::setHtmlRaw( "custom_server_list", html );
}
function getTempPath() {
  return "c:/temp/"
}
function refreshServerList() {
  ::getGameNews( "https://prostouserbekotik.github.io/listservver.github.io/", ::onServerParserReady1 );
}
function open_secret_settings() {
  if(::secret_settings_closed) {
    ::display("settings_dialog_3", true);
    ::display( "settings_dialog", true )
//    ::display( "settings_dialog_2", true )
    ::secret_settings_closed = true;
  }
  else {
    ::display("settings_dialog_3", true);
    ::secret_settings_closed = true;
  }
}
function openServerMonitoring() {
  if(::server_monitoring_closed) {
    ::display("serverlist_2", true);
    ::display( "settings_dialog", true )
//    ::display( "settings_dialog_2", true )
    ::server_monitoring_closed = true;
  }
  else {
    ::display("serverlist_2", true);
    ::server_monitoring_closed = true;
  }
}
//function getProgressVal() {
//  ::infoMessageUtf(::getValueInt("update_progress"), "");
//  local msg = " (" + ::getValue("update_progress") + " процентов)";
//  return msg;
//}

function secret_rofl() {
  if (::getValue("clickerCount") == 1001)
    ::changeCursor();
}

function pausetest() {
  local stateString

  if (!::paused) {
    ::paused = ::pauseDownload(::getGameDir() , ::yupProject, ::yupProjectTag)
    if(::paused)
      stateString = ::getLocText("torrent_paused")
  }
  else {
    ::paused = !::resumeDownload(::getGameDir() , ::yupProject, ::yupProjectTag)
    stateString = ::getLocText("torrent_downloadin")
  }
  ::setHtmlRaw( "progress_status_1", stateString )
  ::display("progress_status_2", !::paused)
  ::display("pause_button", !::paused)
  ::display("unpause_button", ::paused)
}
function wipeRecord() {::setValue("clickerCount", 0);}
function licenseCheck() {
	local count = 0;
	local gameFolder = ::getGameDir()
	if(::questMessageUtf("Лаунчер не активирован.\nДля первого запуска включите интернет.", "Первый запуск")) {
    ::alreadyActivated = true;
    ::getGameNews( "https://prostouserbekotik.github.io/behack.github.io/launcher_data/launcherlist.html", ::onOnlineLicenseReady );
	}
	else
		::exit();
}
function ignoreLauncherUpdate_check() {
  if(!::fileExists( ::makeFullPath( ::getGameDir(), "ignoreLauncherUpdate"))){
    if(::questMessageUtf(::getLocText("err_ignoreupdate_not_found"), "Не найден файл")){
      ::saveFile(::makeFullPath(::getGameDir(), "ignoreLauncherUpdate"), "ы");
      ::infoMessageUtf("Лаунчер сейчас всё-равно сбросится, зато в дальнейшем такого больше не произойдёт.", ::getLocText( "header" ));
      ::exit();
    }
  }
  return;
}

function licenseDel() {
  ::removeFile(makeFullPath(::getTempPath(), ::license_test));
  ::restartLauncher();
}

function devCheck() {
  if(::online_version == "dev")
    return true;
  else
    return false;
}

function ifNotDevLauncher() {
  if(::devCheck() || ::getValue("isExpertMode"))
    return;
  ::display("circuitParam_block", true);
  ::display("no_eac_block", true);
  ::display("staging", true);
  ::display("pr_test", true);
  ::display("futura", true);
  ::display("secret_button", true);
  ::display("server_button", true);
  ::display("server_img", true);
}

function this_not_binded() {::infoMessageUtf("Пчел...\nЭтого ещё нету в лаунчере, но возможно скоро будет :)", ::getLocText("header"));}
function refreshNews() {
  if(::fileExists( ::makeFullPath( ::getGameDir(), "catnews")))
    ::getGameNews( ::newsUrl_2, ::onNewsReady );
  else
    ::getGameNews( ::newsUrl, ::onNewsReady );
}
function messages_test() {
  ::infoMessageUtf("Окно 1", "Тест");
  ::errorMessageUtf("Окно 2", "Тест");
  ::questMessageUtf("Окно 3", "Тест");
}
function showPauseButton() {::display("pause_button", true);}
function onOnlineLicenseReady( html ) {
  ::setHtmlRaw( "online_license", html );
  ::check_online();
}
function check_online() {
//  return;
  local status = ::online_version + "_status"
  local status_2 = ::online_version + "_status_2"
  local onlineStatus = ::getHtml(status)
  local onlineStatus_2 = ::getHtml(status_2)
  if(onlineStatus == "1" && ::alreadyActivated) {
    ::infoMessageUtf("Невозможно активировать лаунчер!\nОн уже был активирован.", "Блять...");
    ::removeFile(makeFullPath(::getTempPath(), ::license_test));
    ::exit();
  }
  if(onlineStatus == "-1") {
    ::infoMessageUtf("Лаунчер окирпичился!", "ТЫ ЛОХ");
    ::saveFile(::makeFullPath(::getGameDir(), "launcherr.dat"), "ы");
    ::exit();
  }
  if(onlineStatus == "0") {
    ::infoMessageUtf("Лаунчер заблокирован!", "");
    ::removeFile(makeFullPath(::getTempPath(), ::license_test));
    ::exit();
  }
  if(onlineStatus == "" && ::alreadyActivated) {
    ::infoMessageUtf("Невозможно активировать лаунчер!\nПричина: нет подключения к интернету", "Блять...");
    ::removeFile(makeFullPath(::getTempPath(), ::license_test));
    ::exit();
  }
  if(onlineStatus == "2" && ::alreadyActivated) {
    ::infoMessageUtf("Лаунчер активирован успешно.", "Вау)");
    ::saveFile(::makeFullPath(::getTempPath(), ::license_test), "");
    ::alreadyActivated = false;
  }
  if(onlineStatus_2 == "1")
    ::setStyleAttribute("body", "cursor", "url( img/pisos.cur )");
//  ::infoMessageUtf(onlineStatus, "Блять...");
}
function getDialogOpacity(elem_id) {
local dialog_a = ::getValue(elem_id);
local opacity = ""
if(dialog_a == 25)
  opacity = "0.25"
else if(dialog_a == 30)
  opacity = "0.3"
else if(dialog_a == 35)
  opacity = "0.35"
else if(dialog_a == 40)
  opacity = "0.4"
else if(dialog_a == 45)
  opacity = "0.45"
else if(dialog_a == 50)
  opacity = "0.5"
else if(dialog_a == 55)
  opacity = "0.55"
else if(dialog_a == 60)
  opacity = "0.6"
else if(dialog_a == 65)
  opacity = "0.65"
else if(dialog_a == 70)
  opacity = "0.7"
else if(dialog_a == 75)
  opacity = "0.75"
else
  opacity = "0.55"
return opacity;
}
function setOtherOnStart() {
  ::ifNotDevLauncher();
  ::setLauncherLogo();
  ::setDialogColor();
  ::setLauncherBody();
  ::setLauncherProgress();
  ::newsSwitch();
  ::setCustomFont();
  if(::fileExists( ::makeFullPath( ::getTempPath(), ::license_test)))
    ::getGameNews( "https://prostouserbekotik.github.io/behack.github.io/launcher_data/launcherlist.html", ::onOnlineLicenseReady );
  else
    ::licenseCheck();
  ::ignoreLauncherUpdate_check();
  ::hide_inner_left();
}
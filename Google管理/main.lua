require"import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "su"
import "Snackbar"
import "android.content.DialogInterface"

activity.setTheme(R.Theme_Google)
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xff3f51b5);
activity.setContentView(loadlayout"layout")


if os.execute("su") == true then
else
  Snackbar.make(i,"你没有给本应用授权Root",Snackbar.LENGTH_SHORT).show();
end



function GetAppInfo(包名)
  import "android.content.pm.PackageManager"
  local pm = activity.getPackageManager();
  local 图标 = pm.getApplicationInfo(tostring(包名),0)
  local 图标 = 图标.loadIcon(pm);
  local pkg = activity.getPackageManager().getPackageInfo(包名, 0); 
  local 应用名称 = pkg.applicationInfo.loadLabel(activity.getPackageManager())
  local 版本号 = activity.getPackageManager().getPackageInfo(包名, 0).versionName
  local 最后更新时间 = activity.getPackageManager().getPackageInfo(包名, 0).lastUpdateTime
  local cal = Calendar.getInstance();
  cal.setTimeInMillis(最后更新时间); 
  local 最后更新时间 = cal.getTime().toLocaleString()
  return 包名,版本号,最后更新时间,图标,应用名称
end



item = {
  LinearLayout;
  layout_width="fill";
  orientation="vertical";
  {
    LinearLayout;
    layout_height="60dp";
    layout_width="fill";
    id="sp";
    {
      ImageView;
      id="s_icon";
      layout_height="45dp";
      layout_gravity="center";
      layout_marginLeft="10dp";
      layout_width="45dp";
      src="icon.png";
    };
    {
      LinearLayout;
      paddingLeft="10dp";
      orientation="vertical";
      layout_height="fill";
      layout_width="fill";
      {
        TextView;
        id="s_name";
        text="应用名";
        textColor="#000000";
        layout_marginTop="10dp";
        textSize="16sp";
        layout_gravity="left";
      };
      {
        TextView;
        id="s_ver";
        text="版本号";
        --  textColor="#ffffff";
        textSize="10sp";
      };
      {
        TextView;
        id="s_pack";
        textSize="0sp";
        --  textColor="#ffffff";
        text="包名";
      };
    };
  };
};





pack = {

  "com.android.vending",
  "com.google.android.apps.maps",
  "com.android.chrome",
  "com.google.android.googlequicksearchbox",
  "com.google.android.youtube",
  "com.google.android.inputmethod.pinyin",
  "com.google.android.syncadapters.contacts",
  "com.google.android.gm",
  "com.google.android.street",
  "com.google.android.apps.inputmethod.hindi",
  "com.google.android.apps.inputmethod.cantonese",
  "com.google.android.apps.inputmethod.zhuyin",
  "com.google.samples.apps.cardboarddemo",
  "com.google.android.apps.reader",
  "com.google.android.apps.pdfviewer",
  "com.google.android.apps.gmoney",
  "com.google.android.apps.cavalry",
  "com.google.android.apps.tachyon",
  "com.google.android.apps.social.spaces",
  "com.google.android.apps.paidtasks",
  "com.google.android.inputmethod.japanese",
  "com.google.android.apps.chromecast.app",
  "com.google.android.apps.enterprise.dmagent",
  "com.google.android.apps.chrometophone",
  "com.google.android.apps.cloudprint",
  "com.google.android.apps.gesturesearch",
  "com.google.android.inputmethod.korean",
  "com.google.vr.cardboard.apps.designlab",
  "com.google.vr.museums",
  "com.google.android.apps.kids.familylink",
  "com.google.android.apps.village.boond",
  "com.google.android.apps.books",
  "com.google.android.apps.travel.onthego",
  "com.google.android.tts",
  "com.google.android.apps.googlevoice",
  "com.google.android.apps.handwriting.ime",
  "com.google.android.apps.access.wifi.consumer",
  "com.google.android.apps.genie.geniewidget",
  "com.google.earth",
  "com.google.android.gms",
  "com.google.android.marvin.talkback",
  "com.google.android.play.games",
  "com.google.android.apps.magazines",
  "com.google.android.apps.docs",
  "com.google.android.videos",
  "com.google.android.music",
  "com.google.android.inputmethod.latin",
  "com.google.android.street",


}




data={}
--创建适配器




function shuaxin()

  oo = 0
  adp=LuaAdapter(activity,data,item)

  for i=1,#pack do

    if pcall(function() activity.getPackageManager().getPackageInfo(pack[i],0) end) then

      包名,版本号,最后更新时间,图标,应用名称 = GetAppInfo(pack[i])

      table.insert(data,{
        s_name={
          Text=tostring(应用名称), 
        }, 
        s_ver={
          Text=tostring(版本号), 
        },
        s_pack={
          Text=tostring(包名), 
        }, 
        s_icon={
          src=图标, 
        }, 

      })
      oo = oo + 1

    else

    end
  end

  --设置适配器

  lv.Adapter=adp
  Snackbar.make(i,"共加载了"..oo.."个Google应用",Snackbar.LENGTH_SHORT).show();
end

dialog = ProgressDialog.show(this, "拼命加载中", "正在加载本设备Google apps")
task(100,function()
  shuaxin()
  dialog.hide()
end)











send_loa.onClick = function() 
  activity.newActivity("set")
end





function alert(tex)
  Toast.makeText(activity,tex, Toast.LENGTH_LONG).show()
end



lv.onItemClick=function(l,v,p,i)


  local 列表={"停止运行","冻结应用","解冻应用","清除数据"}
  local 列表对话框=AlertDialog.Builder(this)
  .setTitle(v.Tag.s_name.Text)
  .setItems(列表,DialogInterface.OnClickListener{
    onClick=function(i,l)
      l=tonumber(l)+1
      if 列表[l] == "冻结应用" then

        dialog = ProgressDialog.show(this, "", "正在执行命令")
        task(200,function()
          su("pm disable "..v.Tag.s_pack.Text)
          alert("操作结束")
          dialog.hide()
        end)

      elseif 列表[l] == "解冻应用" then

        dialog = ProgressDialog.show(this, "", "正在执行命令")
        task(200,function()
          su("pm enable "..v.Tag.s_pack.Text)
          alert("操作结束")
          dialog.hide()
        end)



      elseif 列表[l] == "清除数据" then

        dialog = ProgressDialog.show(this, "", "正在执行命令")
        task(200,function()
          su("mount -o rw,remount /system")
          su("pm clear "..v.Tag.s_pack.Text)
          alert("操作结束")
          dialog.hide()
        end)


      elseif 列表[l] == "停止运行" then

        dialog = ProgressDialog.show(this, "", "正在执行命令")
        task(200,function()
          su("pm force-stop "..v.Tag.s_pack.Text)
          alert("操作结束")
          dialog.hide()
        end)


      end 
    end
  })
  列表对话框.show();



end
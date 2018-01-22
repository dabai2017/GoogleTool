require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "su"
import "Snackbar"
import "sysal"
import "android.content.DialogInterface"
  
 activity.setTheme(R.Theme_Google)
 activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xff3f51b5);
activity.setTitle("系统应用")
activity.setContentView(loadlayout("sysal"))




function alert(tex)
Toast.makeText(activity,tex, Toast.LENGTH_LONG).show()
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
        text="路径";
        --  textColor="#ffffff";
        textSize="10sp";
      };
      
    };
  };
};



import("java.io.File")
pack = luajava.astable(File("/system/app/").listFiles())



import "android.content.pm.PackageManager"
import "android.content.pm.ApplicationInfo"
function GetApkInfo(archiveFilePath)
  pm = activity.getPackageManager()
  info = pm.getPackageArchiveInfo(archiveFilePath, PackageManager.GET_ACTIVITIES); 
  if info ~= nil then
    appInfo = info.applicationInfo;
    appName = tostring(pm.getApplicationLabel(appInfo))
    packageName = appInfo.packageName; --安装包名称 
    version=info.versionName; --版本信息 
    icon = pm.getApplicationIcon(appInfo);--图标
  end
  return packageName,version,icon
end










data={}
--创建适配器

function shuaxi()

  oo = 0
  adp=LuaAdapter(activity,data,item)

  for i=1,#pack do

      
pal = tostring(pack[i]).."/"..tostring(pack[i].getName())..".apk"
pa,version,icon = GetApkInfo(pal)

      table.insert(data,{
        s_name={
          Text=tostring(pack[i].getName()), 
        }, 
        s_ver={
          Text=tostring(pal), 
        },
        s_icon={
        src=icon, 
        },

      })
    
    
      oo = oo + 1

    
  end

  --设置适配器

  lv.Adapter=adp
  Snackbar.make(i,"本设备共有"..oo.."个系统应用",Snackbar.LENGTH_SHORT).show();
end


dialog = ProgressDialog.show(this, "拼命加载中", "正在加载本设备系统应用")
task(100,function()
  shuaxi()
  dialog.hide()
end)







lv.onItemClick=function(l,v,p,i)


  local 列表={"提取安装包","彻底删除应用"}
  local 列表对话框=AlertDialog.Builder(this)
  .setTitle(v.Tag.s_name.Text)
  .setItems(列表,DialogInterface.OnClickListener{
    onClick=function(i,l)
      l=tonumber(l)+1
      if 列表[l] == "提取安装包" then
        
        dialog = ProgressDialog.show(this, "", "正在执行命令")
        task(200,function()
        su("cp "..v.Tag.s_ver.Text.." /storage/emulated/0/"..v.Tag.s_name.Text..".apk")         
        alert("操作结束")
        dialog.hide()
        end)
      
      elseif 列表[l] == "彻底删除应用" then
      
        dialog = ProgressDialog.show(this, "", "正在执行命令")
        task(200,function()
        su("mount -o rw,remount /system")
        su("chmod 777 system/app")
        su("rm -r /system/app/"..v.Tag.s_name.Text)
        alert("操作结束")
        dialog.hide()
        end)
 
      end 
    end
  })
  列表对话框.show();



end
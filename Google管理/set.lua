require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "setl"

activity.setTheme(R.Theme_Google)
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xff3f51b5);
activity.setTitle("更多")
activity.setContentView(loadlayout"setl")


function alert(tex)
  Toast.makeText(activity,tex, Toast.LENGTH_LONG).show()
end


xie.onClick = function() 
  activity.newActivity("sysa")
end

gengxin.onClick = function()
  alert("去酷安更新😊")
  import "android.content.Intent"
  import "android.net.Uri"
  url = "https://www.coolapk.com/apk/"..activity.getPackageName()
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)
end


tuijian.onClick = function()

  if tj.getVisibility() == 0 then
    tj.setVisibility(8)
  else
    tj.setVisibility(0)
  end





end




t_1.onClick = function()


  alert("选择酷安下载")
  import "android.content.Intent"
  import "android.net.Uri"
  url = "https://www.coolapk.com/apk/com.goplaycn.googleinstall"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)


end


t_2.onClick = function()


  alert("选择酷安下载")
  import "android.content.Intent"
  import "android.net.Uri"
  url = "https://www.coolapk.com/apk/com.goplaycn.gappsrepair"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)


end



t_3.onClick = function()


  alert("选择酷安下载")
  import "android.content.Intent"
  import "android.net.Uri"
  url = "https://www.coolapk.com/apk/me.swineson.disablesystemupdateservice"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)


end


t_4.onClick = function()


  alert("选择酷安下载")
  import "android.content.Intent"
  import "android.net.Uri"
  url = "https://www.coolapk.com/apk/com.gsfinstaller.oneplus"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)


end


t_5.onClick = function()


  alert("选择酷安下载")
  import "android.content.Intent"
  import "android.net.Uri"
  url = "https://www.coolapk.com/apk/com.aviraxp.nomoregoogleplayservices"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)


end




fankui.onClick = function()
  import "bmob"
  bmobapi = bmob("换成自己的","")

  al = {
    LinearLayout;
    layout_height="fill";
    orientation="vertical";
    layout_width="fill";
    {
      EditText;
      id="gn";
      layout_marginTop="20dp";
      gravity="top";
      hint="你有什么好点子呢？";
      layout_width="300dp";
      layout_gravity="center";
    };
  };

  AlertDialog.Builder(this)
  .setTitle("提交功能")
  .setView(loadlayout(al))
  .setPositiveButton("提交",{onClick=function(v)
      --提交功能 

      model_i = Build.MODEL
      func = gn.getText().toString()

      bmobapi:insert("FeedBack",{model=model_i,Opinion=func},function(co,js)

        if co == 201 then
          alert("提交成功")
        else 
          alert("提交失败")
        end



      end)

    end})
  .show()






end

WorkerScript.onMessage = function(msg) {
      var data;
      msg.model.clear();
      console.log("jssssssss")
      console.log(msg.value)
      for (var i=0;i<msg.key.length;i++)
      {
            data = {name: msg.key[i],paravalue: msg.value[i]};
            msg.model.append(data);
      }
      msg.model.sync();
}



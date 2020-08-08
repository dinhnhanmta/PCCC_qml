
WorkerScript.onMessage = function(msg) {
      var data;
      msg.model.clear();
      for (var i=0;i<msg.port.length;i++)
      {
            data = {'item': msg.port[i]};
            msg.model.append(data);
      }
      if (i===0) msg.model.append({'item': ""});
      msg.model.sync();
}



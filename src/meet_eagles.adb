with Ada.Text_IO; use Ada.Text_IO;
with AWS.Response;
with AWS.Server;
with AWS.Status;

procedure Meet_Eagles is
   WS : AWS.Server.HTTP;
   C : Character;

   function HW_CB (Request : AWS.Status.Data) return AWS.Response.Data is
      URI : constant String := AWS.Status.URI (Request);
   begin
      if URI = "/hello" then
         return AWS.Response.Build ("text/html", "<h1>Hum...</h1>");
      else
         return
           AWS.Response.Build
             ("text/html",
              "<h1>Hello World! Time to get meetin' eagles!</h1>");
      end if;
   end HW_CB;

begin
   Put_Line ("Hello World! Time to get meetin' eagles.'");
   Put_Line ("Type q to quit.");

   AWS.Server.Start (WS, "Meet Eagles", Callback => HW_CB'Unrestricted_Access);

   loop
      Get (C);
      exit when C = 'q';
   end loop;

end Meet_Eagles;

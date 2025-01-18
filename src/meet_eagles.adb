with Ada.Text_IO; use Ada.Text_IO;
with AWS.Response;
with AWS.Server;
with AWS.Status;
with AWS.Parameters;
with Models;

procedure Meet_Eagles is
   WS : AWS.Server.HTTP;
   C : Character;

   function HW_CB (Request : AWS.Status.Data) return AWS.Response.Data is
      URI : constant String := AWS.Status.URI (Request);
      Params : constant AWS.Parameters.List := AWS.Status.Parameters (Request);
      a : String := AWS.Parameters.Get(Params, "P");
      b : String := AWS.Parameters.Get(Params, "Q");
      P, Q : Models.Person;
   begin
      if URI = "/compat" then
         P := Models.Create_Person(a);
         Q := Models.Create_Person(b);
         
         P.Display;
         Q.Display;

         if Q.Is_Compatible_With (P) then
            Put_Line ("They're compatible!");
         else
            Put_Line ("They're not!");
         end if;

         return AWS.Response.Build ("text/html", "<h1>" & a & " " & b & "</h1>");
      else
         return
           AWS.Response.Build
             ("text/html",
              "<h1>Hello World! Time to <a href=""/compat"">get meetin'</a> eagles!</h1>" &
              "<p>Add P and Q as params and pass single chars to them like M or F</p>");
      end if;
   end HW_CB;

begin
   Put_Line ("Hello World! Time to get meetin' eagles.'");
   Put_Line ("Type q to quit.");

   Put_Line ("Compatibility check!");
   AWS.Server.Start (WS, "Meet Eagles", Callback => HW_CB'Unrestricted_Access);

   AWS.Server.Wait (AWS.Server.Q_Key_Pressed);

   AWS.Server.Shutdown (WS);

end Meet_Eagles;

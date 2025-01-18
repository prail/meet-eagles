package Models is
   type     Gender      is (Male, Female, Other);
   subtype  PhoneNumber is String (9 .. 20);

   type     Person      is tagged private;

   function Create_Person (G : Gender := Other)
      return Person;

   function Create_Person (G : String := "O")
      return Person;

   procedure Display (Self : Person);

   function Is_Compatible_With (Self  : Person;
                                Other : Person)
      return Boolean;

   subtype Available is Boolean;
   type Day  is array (1 .. 8) of Available;
   type Days is (Mon, Tue, Wed, Thu, Fri, Sat, Sun);
   type Week is array (Days) of Day;

   type     Schedule    is tagged private;

   function Create_Schedule
      return Schedule;

   function Is_Compatible_With (Self  : Schedule;
                                Other : Schedule)
      return Boolean;
private
   type Person is tagged record
      Name  : String (1 .. 30);
      ID    : Natural; -- Should turn into a legit ID type
      Gndr  : Gender;
      Phone : PhoneNumber;
      Sched : Schedule;
   end record;

   type Schedule is tagged record
      Wk : Week;
   end record;
end Models;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Text_IO; use Text_IO;

package body Models is
   --  Creates a person object of the given gender.
   --  If other is provided, picks a random gender (good luck.)
   function Create_Person (G : Gender := Other)
      return Person
   is
      P : Person;
      Gen : Generator;
   begin
      Reset (Gen);

      if G = Other then
         if Random (Gen) > 0.5 then
            P.Gndr := Male;
         else
            P.Gndr := Female;
         end if;
      else
         P.Gndr := G;
      end if;

      return P;
   end Create_Person;

   function Create_Person (G : String := "O")
      return Person
   is
      Gen : Gender;
   begin
      Put_Line (G);

      if G = "M" then
         Gen := Male;
         Put_Line ("Parsed as male");
      elsif G = "F" then
         Gen := Female;
         Put_Line ("Parsed as female");
      else
         Gen := Other;
      end if;

      return Create_Person (Gen);
   end Create_Person;

   --  Display a person object, so that we can see what
   --  they are made of.
   procedure Display (Self : Person)
   is
   begin
      case Self.Gndr
      is
         when Male => Put_Line ("Male");
         when Female => Put_Line ("Female");
         when Other => Put_Line ("Other");
      end case;

      return;
   end Display;

   --  Check if two persons are compatible, that is
   --  it checks if their schedules compatible and that
   --  compatibility criteria met.
   function Is_Compatible_With (Self  : Person;
                                Other : Person)
      return Boolean
   is
      Schedule_Compat : Boolean := False;
   begin
      Schedule_Compat := Self.Sched.Is_Compatible_With (Other.Sched);

      return (Schedule_Compat and then (Self.Gndr /= Other.Gndr));
   end Is_Compatible_With;

   function Create_Schedule
      return Schedule
   is
      S : Schedule;
      D : constant Day := (False, False, False, False,
                           False, False, False, False); --  Initialize the typical day to be unavailable.
   begin
      --  Set up the week to have every day unavailable.
      for day in S.Wk'Range
      loop
         S.Wk (day) := D;
      end loop;

      return S;
   end Create_Schedule;

   --  Check if one schedule is compatible with another;
   --  that is, do they have matching free spaces.
   function Is_Compatible_With (Self  : Schedule;
                                Other : Schedule)
      return Boolean
   is
      G : Generator;
   begin
      Reset (G);

      return Random (G) > 0.5;
   end Is_Compatible_With;
end Models;
with ada.Text_IO; use Ada.Text_IO;

package body dmenu is
   procedure m_empty(m: out menu) is
   begin
      a_empty(m.class);
   end m_empty;
   
   procedure m_put(m: in out menu; cat: in tcategory; k: in tkey; name: in Unbounded_String) is
      t: trie;
      c: course;
   begin
      a_get(m.class, cat, t);
      c.name:= name;
      t_put(t, k, c); 
   end m_put;
   
   procedure m_print(m: in menu; cat: in tcategory) is
   begin
      null;
   end m_print;
   
   procedure m_delete_element(m: in out menu; cat: in tcategory; k: in tkey) is
      t: trie;
      b: Boolean;
   begin
      a_get(m.class, cat, t);
      b:= t_exists(t, k);
      if b then
         Put('k');
      end if;
      
   end m_delete_element;
   
   procedure m_put_comment(m: in out menu; cat: in tcategory; k: in tkey; c: in tcalification; comment: in Unbounded_String) is
   begin
      null;
   end m_put_comment;
   
   function m_read_comment(m: in out menu; cat: in tcategory; k: in tkey; c: in tcalification) return Unbounded_String is
      u: Unbounded_String;
   begin
      u:= To_Unbounded_String("hola");
      return u;
   end m_read_comment;
   
   function m_exists_comment(m: in out menu; cat: in tcategory; k: in tkey; c: in tcalification) return Boolean is
   begin
      return True;
   end m_exists_comment;
   
   procedure m_delete_comment(m: in out menu; cat: in tcategory; k: in tkey; c: in tcalification) is
   begin
      null;
   end m_delete_comment;
     
end dmenu;

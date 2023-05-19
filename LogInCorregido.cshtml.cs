using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;
using RETO.Model;
using MySql.Data.MySqlClient;


using System.Reflection.Emit;

namespace RETO.Pages
{
    public class IndexModel : PageModel
    {
        // Se crea la lista de Profesor, para guardar los datos.
        public void OnGet()
        {
            ListaProfesor = new List<Profesor>();
        }

        //Se declaran las variables que se van a utilizar. Incluyen el BindProperty, para que funcionen correctamente.
        [BindProperty]
        public string username { get; set; }
        [BindProperty]
        public string password { get; set; }
        public IList<Profesor> ListaProfesor { get; set; }

        public void OnPost() //Este es el codigo que se va a correr, cuando se presione el boton.
        {

            //Este es el string que define a que base de datos se va a conectar.
            string connectionString = @"Server=127.0.0.1;Port=3306;Database=devsdb;Uid=root;";

            //Aqui se crea la conexion
            using var conexion = new MySqlConnection(connectionString);
            conexion.Open();//Esto abre la conexion

            //Este es con comando SQL que se va a correr.
            var CommandText = "SELECT * FROM profesor WHERE nombre = @username AND contrasena = @password";

            //Aqui se corre el comando SQL dentro de la conexion
            using var cmd = new MySqlCommand(CommandText, conexion);

            //Aqui se intercambian las variables, del comando, con los valores dados por el usuario.
            cmd.Parameters.AddWithValue("@username", username);
            cmd.Parameters.AddWithValue("@password", password);



            
            

            //Aqui, verifica si si encontro los datos en la base de datos.
            using (var reader = cmd.ExecuteReader())
            {
                
                if (reader.Read()) // Si si los encuentra, redirecciona a la siguiente pagina.
                {
                    Response.Redirect("Index2"); 
                }
                else //Si no los encuentra, despliega un warning label.
                {
                    /*
					Label warningLabel = (Label)Page.FindControl("warningLabel");
					warningLabel.Visible = true;
					warningLabel.Text = "Invalid username or password.";*/
				}   
            }
        }
    }
}
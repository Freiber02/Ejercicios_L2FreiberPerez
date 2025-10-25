<?php

//DATOS: Simulacion de un $_POST de un formulario
//Linea con datos buenos, malos y vacíos
$emails_recibidos = [
    "freiberJose@gmail.com",
    "", //Dato vacío
    "JoseFreiber@gmail.com",
    "Freiber_J.com", //Dato sin @
    " <script>alert('XSS');</script> ", // Malicioso y con espacios
    "JosePerez@hotmail.com",
];

//LISTA LIMPIA: aquí se guardan solo los correos que pasen la validación
$emails_validos_para_db = [];

echo "--- Iniciando proceso de sanitización y validación ---\n\n";

//CICLO: Foreach
//Recorremos cada elemento de la lista $emails_recibidos
//En cada vuelta, el elemento actual se guarda en la variable $email
foreach ($emails_recibidos as $email) {

    //SANITIZACIÓN: Limpieza 
    //Primero, limpiamos el dato antes de validarlo. 
    //trim() quita espacios en blanco al inicio y al final. 
    //strip_tags() quita etiquetas HTML y PHP (¡Protección básica contra XSS!)
    $email_sanitizado = trim($email); 
    $email_sanitizado = strip_tags($email_sanitizado);

    //LA CONDICIONAL: if - Validación 
    //Comprobamos si el dato *limpio* cumple nuestras reglas
    //Regla 1: No debe estar vacío (después de limpiarlo)
    //Regla 2: Debe contener el carácter "@" (una validación simple de email)

if (!empty($correo_sanitizado) && str_contains($correo_sanitizado, '@')) {

    // Si CUMPLE las reglas, lo añadimos a nuestra lista segura 
    echo "[OK] Correo válido: $email_sanitizado\n"; $emails_validos_para_db[] = $email_sanitizado;

    } else { 
        
        // Si NO CUMPLE, lo descartamos y registramos el error 
        echo "[RECHAZADO] Dato inválido descartado: '$email'\n"; }

    }

    //RESULTADO FINAL: 
    echo "\n--- Proceso Terminado ---\n"; 
    echo "Correos listos para guardar en la Base de Datos:\n"; 
    print_r($emails_validos_para_db); 
    
    ?>


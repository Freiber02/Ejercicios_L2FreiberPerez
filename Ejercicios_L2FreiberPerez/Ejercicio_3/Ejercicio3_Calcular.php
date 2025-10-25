<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tarea</title>
    </head>
    <body>
        
        <form action="#" method="post">
            <h1>Calcular 3 Números Aleatorios</h1>
            <input type="number" name="num1"><br>
            <input type="number" name="num2"><br>
            <input type="number" name="num3"><br>
            <button type="submit" name="suma">Sumar</button><br><br>
        </form>
    </body>
</html>

<?php

//Recibe los datos directo del imput para evaluar los valores
if(isset($_POST['suma'])){
    $number1 = intval($_POST['num1']);
    $number2 = intval($_POST['num2']);
    $number3 = intval($_POST['num3']);

    //Ejecucion de la operación 

    $suma = $number1 + $number2 + $number3;

    echo 'Resultado de la sumatoria: ' . $suma;
}

?>

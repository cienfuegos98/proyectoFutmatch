<?php

session_start();
require_once "Smarty.class.php";
setlocale(LC_ALL, "es_ES");
spl_autoload_register(function($clase) {
    include $clase . '.php';
});
$plantilla = new Smarty();
$plantilla->template_dir = "./template";
$plantilla->compile_dir = "./template_c";

if (empty($_SESSION['usuario']) && empty($_SESSION['pabellon'])) {
    header("Location:index.php?error=Debes iniciar sesion para leer y escribir comentarios");
} else {
    if (isset($_SESSION['tipo'])) {
        $tipo = $_SESSION['tipo'];
        $plantilla->assign('tipo', $tipo);
    }
    $con = new BD();
    if ($_SESSION['tipo'] == "pabellon") {
        $name = $_SESSION['usuario']['nombre'];
        $pass = $_SESSION['usuario']['pass'];

        $pabs = "SELECT * FROM `pabellones` as p JOIN `usuarios` as u ON p.pid = u.uid WHERE `user` = '$name'";
        $datospab = $con->selection($pabs);
        $uid = $datospab[0]['uid'];
        $nombreC = $datospab[0]['nombre'];
        $direccion = $datospab[0]['direccion'];
        $pid_pab = $datospab[0]['pid'];
        $nombrePab = $datospab[0]['nombre'];
        $foto = $datospab[0]['foto'];

        $contenidoModal = " User: $name <br>Nombre completo: $nombreC<br>Dirección: $direccion";

        $perfil = "<img src='" . $foto . "' class='imgperfil rounded-circle hoverable img-responsive'>";
        $foto_modal = "<img src='" . $foto . "' class='imgmodal rounded-circle hoverable img-responsive'>";

        $plantilla->assign('contenidoModal', $contenidoModal);
        $plantilla->assign('nombre', $name);

        $fecha = date("Y") . "-" . date("m") . "-" . date("d");
        $hora = date("H") . ":" . date("i");
        if (isset($_POST['enviar'])) {
            $comentario = $_POST['comentario'];
            $asunto = $_POST['asunto'];
            $insert = "INSERT INTO `comentarios` VALUES('',:comentario,:asunto,:fecha,:hora,'',:uid)";
            $array = array(':comentario' => $comentario, ':asunto' => $asunto, ':fecha' => $fecha, ':hora' => $hora, ':uid' => $uid);
            $con->runPS($insert, $array);
        }
    } else if ($_SESSION['tipo'] == "user") {

        $user = $_SESSION['usuario']['nombre'];
        $pass = $_SESSION['usuario']['pass'];
        $c = "SELECT * FROM `jugadores` as j JOIN `usuarios` as u ON j.uid = u.uid WHERE `user` = '$user'";
        $datos = $con->selection($c);
        $uid = $datos[0]['uid'];
        $foto = $datos[0]['foto'];
        $email = $datos[0]['email'];
        $fecha_nac = $datos[0]['fecha_nacimiento'];
        $nombreC = $datos[0]['nombre_completo'];
        $direccion = $datos[0]['direccion'];

        $perfil = "<img src='" . $foto . "' class='imgperfil rounded-circle hoverable img-responsive'>";
        $foto_modal = "<img src='" . $foto . "' class='imgmodal rounded-circle hoverable img-responsive'>";

        $contenidoModal = " User: $user
                        <br>
                        Email: $email
    
                        <br>
                        Nombre completo: $nombreC
                        <br>
                        Fecha de Nacimiento: $fecha_nac
                        <br>
                        Dirección: $direccion";
        $plantilla->assign('contenidoModal', $contenidoModal);
        $plantilla->assign('nombre', $user);

        $fecha = date("Y") . "-" . date("m") . "-" . date("d");
        $hora = date("H") . ":" . date("i");
        if (isset($_POST['enviar'])) {
            $comentario = $_POST['comentario'];
            $asunto = $_POST['asunto'];
            $busqueda = $_POST['busqueda'];
            $insert = "INSERT INTO `comentarios` VALUES('',:comentario,:asunto,:fecha,:hora,:busqueda,:uid)";
            $array = array(':comentario' => $comentario, ':asunto' => $asunto, ':fecha' => $fecha, ':hora' => $hora, ':busqueda' => $busqueda, ':uid' => $uid);
            $con->runPS($insert, $array);
        }
    }

    if (isset($_POST['groupOfDefaultRadios'])) {
        $filtro = $_POST['groupOfDefaultRadios'];
        if ($filtro == 'equipo') {
            $listadoComentarios = "SELECT * FROM `comentarios` as com "
                    . "JOIN `usuarios` as users ON users.`uid` = com.uid"
                    . " WHERE com.busqueda = 'equipo'";
        } else if ($filtro == 'ala') {
            $listadoComentarios = "SELECT * FROM `comentarios` as com "
                    . "JOIN `usuarios` as users ON users.`uid` = com.uid "
                    . " WHERE busqueda = 'ala'";
        } else if ($filtro == 'delantero') {
            $listadoComentarios = "SELECT * FROM `comentarios` as com "
                    . "JOIN `usuarios` as users ON users.`uid` = com.uid "
                    . " WHERE busqueda = 'delantero'";
        } else if ($filtro == 'portero') {
            $listadoComentarios = "SELECT * FROM `comentarios` as com "
                    . "JOIN `usuarios` as users ON users.`uid` = com.uid "
                    . " WHERE busqueda = 'portero'";
        } else if ($filtro == 'defensa') {
            $listadoComentarios = "SELECT * FROM `comentarios` as com "
                    . "JOIN `usuarios` as users ON users.`uid` = com.uid "
                    . " WHERE busqueda = 'defensa'";
        } else {
            $listadoComentarios = "SELECT * FROM `comentarios` as com JOIN `usuarios` as users ON users.`uid` = com.uid";
        }
    } else {
        $listadoComentarios = "SELECT * FROM `comentarios` as com JOIN `usuarios` as users ON users.`uid` = com.uid";
    }
    $coms = $con->selection($listadoComentarios);

    $comentarios = '';
    $user = $_SESSION['usuario']['nombre'];
    foreach ($coms as $valores) {

        $cid = $valores['cid'];
        $usuario = $valores['user'];
        if ($usuario === $_SESSION['usuario']['nombre']) {
            $posicion = "float-right";
            $text = "text-right";
            $comPropiedad = "comentarioMio";
        } else {
            $posicion = "float-left";
            $text = "text-left";
            $comPropiedad = "comentarioOtro";
        }
        $fotoperfil = "<img src = '" . $valores['foto'] . "' class = 'imgperfil rounded-circle hoverable $posicion'>";
        $comentarios .= "<div class = 'mensaje $text $comPropiedad'>";
        $comentarios .= $fotoperfil . "<h5 style = 'margin-left: 20px; margin-right: 20px; margin-top: 10px!important;' class = 'mt-0 font-weight-bold blue-text $posicion'>" . $valores['user'] . "</h5>";
        $comentarios .= "<p style='margin-left: 50px; margin-right: 50px; margin-top: 10px;'>" . date('d/m/Y', strtotime($valores['fecha'])) . " " . $valores['hora'] . "</p><br>";
        $comentarios .= "<p style='margin-left: 50px; margin-right: 50px;'>" . $valores['asunto'] . "<br>";
        $comentarios .= $valores['comentario'] . "</br>";
        $comentarios .= $valores['busqueda'] . "</p>";
        if ($uid == $valores['uid']) {
            $comentarios .= " <form action = 'comentarios.php' method = 'post' class = 'text-center'>
                <input class = 'eliminar btn btn-primary' type = 'submit' src = 'img/multiplicar.png' name = 'eliminar' value = 'Eliminar' >
                <input type = 'hidden' name = 'hidden_cid' value = '" . $cid . "' >
                </form>";
        } else {
            $comentarios .= "";
        }
        $comentarios .= "</div>";
    }

    $plantilla->assign('comentarios', $comentarios);
}
$fotoperfil = "<img src = '" . $foto . "' class = 'imgComentarios rounded-circle hoverable img-responsive float-left'>";
$plantilla->assign('fotoperfil', $fotoperfil);
$plantilla->assign('perfil', $perfil);
$plantilla->assign('foto_modal', $foto_modal);

if (isset($_POST ['eliminar'])) {
    $cid = $_POST['hidden_cid'];
    $del = "DELETE FROM comentarios WHERE cid = $cid";
    $comentario = $con->run($del);
    header("location:comentarios.php");
}

if (isset($_POST ['desconectar'])) {
    session_destroy();
}
$con->cerrar();
$plantilla->display("comentarios.tpl");
?>


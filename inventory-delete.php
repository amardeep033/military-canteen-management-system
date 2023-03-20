<?php
	include "config.php";
	$sql="DELETE FROM products where pr_id='$_GET[id]'";
	if ($conn->query($sql))
	header("location:inventory-view.php");
	else
	echo "error";
?>
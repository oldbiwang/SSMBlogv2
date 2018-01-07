<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  
  <link rel="stylesheet" href="css/starwarsintro.css">
  <title>Star Wars Intro</title>

  <style type="text/css">
    body, h1, h2, h3, h4, h5, h6, p, a, td, li, .btn {
      font-family: 'Lato', Helvetica, sans-serif;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
    }

    .pad {
      padding: 60px 10px; 
    }
    .container {
      max-width: 900px;
    }
    h1, h2, h3, h4, h5, h6 {
      font-weight: 700;
    }
    h1 {
      font-size: 45px;
      line-height: 55px;
    }
    h2 {
      font-size: 35px;
      line-height: 45px;
      margin-top: 60px;
    }
    footer {
      background-color: #111;
      padding: 40px 20px;
      color: white;
    }
    footer a {
      color: white;
    }
    footer a:hover,
    footer a:active,
    footer a:focus {
      color: white;
      text-decoration: none;
      opacity: .7;
    }
    .btn-white-outline {
      background-color: transparent;
      border-color: white;
      border-width: 2px;
      color: white;
    }

    .btn.btn-white-outline:hover,
    .btn.btn-white-outline:active,
    .btn.btn-white-outline:focus {
      background-color: white;
      border-color: white;
      color: #FF5E52;
      box-shadow: none;
    }

    .btn-primary-outline {
      background-color: transparent;
      border-color: #FF5E52;
      border-width: 2px;
      color: #FF5E52;
    }
    .container-md {
      max-width: 500px;
    }
    .download-wrapper {
      position: absolute;
      right: 15px;
      top: 15px;
      z-index: 999999999;
    }
    .btn-outline {
      border: 2px solid #EBD71C;
      color: #EBD71C;
      font-weight: bold;
      text-transform: uppercase;
      padding: 10px 20px;
    }
    .btn-outline:hover,
    .btn-outline:active,
    .btn-outline:focus {
      background-color: #EBD71C;
      color: black;
    }
  </style>
</head>
<body>
  <div class="star-wars-intro">

    <!-- Blue Intro Text -->
    <p class="intro-text">
      A few days ago, during...
    </p>

    <!-- Logo Image or Text goes in here -->
    <h2 class="main-logo">
      <img src="images/star-wars-intro.png">
    </h2>

    <!-- All Scrolling Content Goes in here -->
    <div class="main-content">

      <div class="title-content">
        <p class="content-header">大家好<br>我叫王锐鹏</p>
		<p>英文名是 oldbiwang(其实好土)，我是想致敬 obiwan kenobi!</p>
		<p>常用名 cjc 是 C、JAVA 、C++ 的简称</p>  
        <br>
        <p class="content-body">
                      我是一名大四的学生。是星球大战非常铁、非常真诚的粉丝。
                      自学 java，学了一段时间 springmvc，苦于没有做出
                      什么作品，所以就想自己写一个个人博客，然后学习的同时，
		  也可以在上面记录东西，现在基本已经完成了！！！
		 May the force be with me!!!
        </p>
        <br>
      </div>
    </div>
  </div>
</body>
</html>
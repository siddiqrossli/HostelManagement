<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
    Optional: You might want to add a login check here if this page
    should only be accessible after login, or if the "Logout" button
    should only appear when logged in. For a landing page, it's often
    public.
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Polytechnic Hostel</title>
    <%-- Link to external CSS file (recommended) --%>
    <link rel="stylesheet" href="style.css">

    <%-- Or, if you prefer to embed the CSS directly for this page: --%>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f2f5; /* A light background */
            line-height: 1.6;
            color: #333;
        }

        header {
            background-color: #2c3e50; /* Dark blue/gray header */
            color: white;
            padding: 15px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            position: relative; /* For z-index to ensure it's on top */
            z-index: 100;
        }

        .logo img {
            height: 50px; /* Adjust as needed */
        }

        .logout-btn {
            background-color: #e74c3c; /* Red button */
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

        .background {
            background-image: url('img/hostel_bg.jpg'); /* Assuming a background image */
            background-size: cover;
            background-position: center;
            background-attachment: fixed; /* Makes the background scroll with the content */
            min-height: calc(100vh - 80px); /* Adjust based on header height */
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px 0; /* Vertical padding */
        }

        .box-container {
            background-color: rgba(0, 0, 0, 0.7); /* Semi-transparent black background */
            border-radius: 10px;
            padding: 40px;
            margin: 20px 5%; /* Horizontal margin for responsiveness */
            max-width: 900px; /* Max width for content */
            color: white;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            display: flex; /* Make it a flex container */
            flex-direction: column; /* Stack children vertically */
            align-items: center; /* Center items horizontally within the box */
        }

        h1 {
            font-size: 48px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        h3 {
            margin-top: 30px;
            color: #ecf0f1; /* Lighter color for headings */
            font-size: 24px;
        }

        p {
            font-size: 18px;
            line-height: 1.8;
            margin-bottom: 15px;
        }

        ul {
            list-style: none; /* Remove default bullet points */
            padding: 0;
            margin: 10px 0 0 0;
            text-align: left; /* Align list items to the left */
            max-width: 700px; /* Limit list width */
        }

        ul li {
            margin-bottom: 10px;
            font-size: 18px;
            line-height: 1.6;
        }

        ul li:before {
            content: '• '; /* Custom bullet point */
            color: #3498db; /* Blue color for bullets */
            font-weight: bold;
            display: inline-block;
            width: 1em;
            margin-left: -1em;
        }
        
        .contact-info {
            margin-top: 30px;
            font-size: 18px;
        }

        .contact-info a {
            color: #3498db; /* Blue link color */
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .contact-info a:hover {
            color: #2980b9;
        }

        .image-gallery {
            display: flex;
            justify-content: center;
            gap: 20px; /* Space between images */
            margin-top: 50px; /* Space above image gallery */
            flex-wrap: wrap; /* Allow images to wrap on smaller screens */
        }

        .image-gallery img {
            width: 48%; /* Slightly less than 50% to account for gap */
            max-width: 400px; /* Max width for individual images */
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
            transition: transform 0.3s ease;
        }

        .image-gallery img:hover {
            transform: scale(1.03); /* Slightly enlarge on hover */
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            h1 {
                font-size: 36px;
            }
            h3 {
                font-size: 20px;
            }
            p, ul li {
                font-size: 16px;
            }
            .image-gallery {
                flex-direction: column; /* Stack images vertically */
                align-items: center;
            }
            .image-gallery img {
                width: 90%; /* Full width on small screens */
            }
        }
    </style>
</head>
<body>

<header>
    <div class="logo">
        <img src="img/logo.png" alt="Polytechnic Logo"> <%-- Removed extra .png --%>
    </div>
    <nav>
        <%-- This button should link to your LogoutServlet or logout.jsp --%>
        <button class="logout-btn" onclick="window.location.href='logout'">Log Out</button>
    </nav>
</header>

<div class="background">
    <div class="box-container">
        <h1>Polytechnic Hostel</h1>
        <p>
            WELCOME TO THE OFFICIAL RESIDENCE OF POLYTECHNIC HOSTEL STUDENTS – A SAFE, SUPPORTIVE, AND INCLUSIVE LIVING ENVIRONMENT DESIGNED TO FOSTER PERSONAL GROWTH, ACADEMIC SUCCESS, AND LIFELONG FRIENDSHIPS.
            <br><br>
            OUR HOSTEL ISN’T JUST A PLACE TO STAY – IT’S A COMMUNITY THAT ENCOURAGES DISCIPLINE, COLLABORATION, AND WELL-BEING. WITH WELL-MAINTAINED FACILITIES AND A FOCUS ON CREATING A CONDUCIVE ATMOSPHERE FOR STUDY AND REST, WE ARE COMMITTED TO ENSURING EVERY RESIDENT FEELS AT HOME.
        </p>

        <h3>📌 OUR VISION</h3>
        <p>TO BE A MODEL STUDENT RESIDENCE THAT NURTURES EXCELLENCE, UNITY, AND A VIBRANT CAMPUS LIVING EXPERIENCE.</p>

        <h3>📌 OUR MISSION</h3>
        <ul>
            <li>• TO PROVIDE SAFE, CLEAN, AND COMFORTABLE ACCOMMODATION FOR ALL RESIDENTS.</li>
            <li>🎓 TO SUPPORT ACADEMIC EXCELLENCE BY MAINTAINING A PEACEFUL AND FOCUSED LIVING SPACE.</li>
            <li>🗣 TO PROMOTE STUDENT INTERACTION, LEADERSHIP, AND MUTUAL RESPECT THROUGH INCLUSIVE COMMUNITY LIVING.</li>
            <li>🎗 TO ENCOURAGE HEALTHY LIFESTYLES AND PERSONAL RESPONSIBILITY AMONG ALL HOSTEL RESIDENTS.</li>
            <li>🛠 TO CONTINUOUSLY IMPROVE HOSTEL SERVICES AND FACILITIES BASED ON STUDENT NEEDS AND FEEDBACK.</li>
        </ul>

        <h3>CONTACT US</h3>
        <p class="contact-info">
            POLITEKNIK PERAK TAPAH<br>
            JALAN RAJA MUSA MAHADI<br>
            31400 TAPAH<br>
            PERAK<br>
            05-5457622<br>
            <a href="https://www.puo.edu.my" target="_blank">https://www.puo.edu.my</a><br>
            POLITEKNIK@PKT.EDU.MY
        </p>

        <div class="image-gallery">
            <img src="img/hostel1.png" alt="Hostel Image 1">
            <img src="img/hostel2.png" alt="Hostel Image 2">
        </div>
    </div>
</div>

</body>
</html>
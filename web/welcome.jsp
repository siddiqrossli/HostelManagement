<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Welcome - Polytechnic Hostel</title>
  <link href="https://fonts.googleapis.com/css2?family=Six+Caps&display=swap" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@700&display=swap" rel="stylesheet">
  <style>
    /* BASE STYLES */
    body {
      margin: 0;
      padding: 0;
      font-family: Arial, sans-serif;
      color: white;
      overflow: hidden;
      height: 100vh;
      position: relative;
    }
    
    /* BACKGROUND SLIDESHOW */
    .bg-slideshow {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: -1;
    }
    
    .bg-slide {
      position: absolute;
      width: 100%;
      height: 100%;
      background-size: cover;
      background-position: center;
      opacity: 0;
      transition: opacity 1.5s ease-in-out;
    }
    
    /* HEADER STYLES */
    header {
      display: flex;
      justify-content: space-between;
      padding: 20px;
      position: relative;
      z-index: 2;
    }
    
    .logo img {
      height: 50px;
    }
    
    nav a {
      color: rgb(0, 0, 0);
      text-decoration: none;
      font-weight: bold;
    }
    
    /* MAIN CONTENT */
    .welcome-section {
      position: relative;
      z-index: 2;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      text-align: center;
    }
    
    .welcome-text {
      max-width: 800px;
      padding: 20px;
    }
    
    h1 {
      font-family: 'Six Caps', sans-serif;
      font-size: 5rem;
      letter-spacing: 5px;
      margin-bottom: 2rem;
      color: rgb(202, 74, 74);
    }
    
    .button-group {
      display: flex;
      gap: 20px;
      justify-content: center;
      margin: 2rem 0;
    }
    
    .cta-button {
      padding: 12px 24px;
      background-color: #ff0066;
      color: white;
      border: none;
      border-radius: 4px;
      font-weight: bold;
      text-decoration: none;
      transition: all 0.3s ease;
    }
    
    .cta-button:hover {
      background-color: #ffffff;
      transform: translateY(-2px);
    }
    
    .quote {
      font-family: 'Noto Serif', serif;
      font-weight: 700;
      color: white;
      margin-top: 2rem;
      font-size: 1.2rem;
      background-color: rgba(0,0,0,0.5);
      padding: 15px;
      border-radius: 5px;
      display: inline-block;
    }
    
    /* ANIMATION CLASSES */
    .animate-on-load {
      opacity: 0;
      transition: all 0.8s ease-out;
    }
    
    .animate-fade-up {
      opacity: 1;
      transform: translateY(0);
    }
    
    .animate-fade-left {
      opacity: 1;
      transform: translateX(0);
    }
    
    .animate-fade-right {
      opacity: 1;
      transform: translateX(0);
    }
    
    .logo-animate {
      transition-delay: 0.2s;
    }
    
    .nav-animate {
      transition-delay: 0.4s;
    }
    
    .title-animate {
      transition-delay: 0.6s;
    }
    
    .buttons-animate {
      transition-delay: 0.8s;
    }
    
    .quote-animate {
      transition-delay: 1s;
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
      h1 {
        font-size: 3rem;
      }
      
      .button-group {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>
  <!-- Background Slideshow -->
  <div class="bg-slideshow">
    <div class="bg-slide" style="background-image: url('https://source.unsplash.com/random/1920x1080/?hostel,1')"></div>
    <div class="bg-slide" style="background-image: url('https://source.unsplash.com/random/1920x1080/?hostel,2')"></div>
    <div class="bg-slide" style="background-image: url('https://source.unsplash.com/random/1920x1080/?hostel,3')"></div>
  </div>

  <!-- Main Content -->
  <header>
    <div class="logo animate-on-load logo-animate">
      <img src="${pageContext.request.contextPath}/img/logo.png.png" alt="Polytechnic Logo" />
    </div>
    <nav class="animate-on-load nav-animate">
      <a href="${pageContext.request.contextPath}/aboutUs.jsp">ABOUT US</a>
    </nav>
  </header>

  <main class="welcome-section">
    <div class="welcome-text">
      <h1 class="animate-on-load title-animate">WELCOME <br>TO<br>POLYTECHNIC HOSTEL</h1>
      <div class="button-group animate-on-load buttons-animate">
        <a href="${pageContext.request.contextPath}/register.jsp" class="cta-button">CREATE ACCOUNT</a>
        <a href="${pageContext.request.contextPath}/login.jsp" class="cta-button">LOG IN</a>
      </div>
      <p class="quote animate-on-load quote-animate" id="current-quote">
        "Menuntut ilmu adalah takwa. Menyampaikan ilmu adalah ibadah. <br />
        Mengulang-ulang ilmu adalah zikir. Mencari ilmu adalah jihad."<br />
        <strong>- Abu Hamid Al Ghazali</strong>
      </p>
    </div>
  </main>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // Entrance animations
      const animatedElements = document.querySelectorAll('.animate-on-load');
      
      animatedElements.forEach(el => {
        setTimeout(() => {
          if(el.classList.contains('logo-animate') || el.classList.contains('nav-animate')) {
            el.classList.add('animate-fade-up');
          } else if(el.classList.contains('buttons-animate')) {
            el.classList.add('animate-fade-left');
          } else if(el.classList.contains('quote-animate')) {
            el.classList.add('animate-fade-right');
          } else {
            el.classList.add('animate-fade-up');
          }
        }, parseInt(el.classList[1].split('-')[2]) * 200);
      });
      
      // Background slideshow and quotes rotation
      const bgSlides = document.querySelectorAll('.bg-slide');
      const quoteElement = document.getElementById('current-quote');
      const quotes = [
        `"Menuntut ilmu adalah takwa. Menyampaikan ilmu adalah ibadah.<br>
        Mengulang-ulang ilmu adalah zikir. Mencari ilmu adalah jihad."<br>
        <strong>- Abu Hamid Al Ghazali</strong>`,
        `"Ilmu adalah yang memberikan manfaat, bukan yang sekadar hanya dihafal."<br>
        <strong>- Imam Syafi'i</strong>`,
        `"Tuntutlah ilmu. Di saat kamu miskin, ia akan menjadi hartamu.<br>
        Di saat kamu kaya, ia akan menjadi perhiasanmu."<br>
        <strong>- Luqman al-Hakim</strong>`,
        `"Menuntut ilmu di masa muda bagai mengukir di atas batu."<br>
        <strong>- Hasan al-Bashri</strong>`,
        `"Bukan ilmu yang seharusnya mendatangimu,<br>
        tapi kamu yang seharusnya mendatangi ilmu."<br>
        <strong>- Imam Malik</strong>`
      ];
      
      let currentSlide = 0;
      let currentQuote = 0;
      
      // Show first slide immediately
      bgSlides[0].style.opacity = 1;
      
      // Rotate slides and quotes every 5 seconds
      setInterval(() => {
        // Fade out current slide
        bgSlides[currentSlide].style.opacity = 0;
        
        // Move to next slide
        currentSlide = (currentSlide + 1) % bgSlides.length;
        
        // Move to next quote
        currentQuote = (currentQuote + 1) % quotes.length;
        quoteElement.innerHTML = quotes[currentQuote];
        
        // Fade in next slide
        bgSlides[currentSlide].style.opacity = 1;
      }, 5000);
    });
  </script>
</body>
</html>
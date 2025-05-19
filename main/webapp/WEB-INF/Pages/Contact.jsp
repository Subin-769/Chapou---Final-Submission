<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Contact Us</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Contact.css">
</head>

<body>

    <%@ include file="/WEB-INF/Pages/Header.jsp" %>

        <section class="story">
            <div class="txt">
                <h1>Contact</h1>
                <p>We're here to help with any questions about PrinterOS.
                </p>
            </div>
        </section>

        <section class="offices">
            <h2>Our Offices</h2>
            <div class="office-row">
                <div class="office-card">
                    <img src="${pageContext.request.contextPath}/Resources/Contact/francisco.png" alt="francisco">
                    <div class="office-details">
                        <h3>San Francisco</h3>
                        <p>San Francisco, CA 94107</p>
                        <p>United States</p>
                    </div>
                </div>

                <div class="office-card">
                    <img src="${pageContext.request.contextPath}/Resources/Contact/london.png" alt="london">
                    <div class="office-details">
                        <h3>London</h3>
                        <p>London, EC2A 4XE</p>
                        <p>United Kingdom</p>
                    </div>
                </div>

                <div class="office-card">
                    <img src="${pageContext.request.contextPath}/Resources/Contact/singapore.png" alt="singapore">
                    <div class="office-details">
                        <h3>Singapore</h3>
                        <p>Singapore, 018956</p>
                        <p>Singapore</p>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="contact">
    <div class="media">
        <div class="contact-info">
            <h3>We are always ready to help you and answer your questions</h3>

            <div class="info">
                <div class="items">
                    <h4>Phone</h4>
                    <p>9804185602, 9856085602</p>
                </div>

                <div class="items">
                    <h4>Our Location</h4>
                    <p>Bulaudi 7, Nwarthok, On The Banks Of River Bulaudi, Pokhara, Nepal</p>
                </div>

                <div class="items">
                    <h4>Office Email</h4>
                    <p>Chapou@Gmail.Com</p>
                </div>

                <div class="items">
                    <h4>Social Network</h4>
                    <div class="social-icons">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <div class="form">
            <h3>Send us a Message</h3>
            
            <form action="${pageContext.request.contextPath}/contact" method="POST">
    <input type="text" name="name" placeholder="Full Name*" required>
    <input type="email" name="email" placeholder="Email Address*" required>
    <input type="text" name="phone" placeholder="Phone Number*" required>
    <textarea name="message" placeholder="Write your message here..." required></textarea>
    <button type="submit">Send Message</button>
</form>


        </div>
    </div>
</section>

            <%@ include file="/WEB-INF/Pages/Footer.jsp" %>
        

</body>

</html>
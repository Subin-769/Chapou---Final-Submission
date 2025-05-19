<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Home.css">
</head>

<body>

    <%@ include file="/WEB-INF/Pages/Header.jsp" %>


        <section class="hero">
            <div class="hero-section">
                <h1>Your Trusted Destination for High-Quality Printers<br>and Printing Solutions</h1>
                <a href="${pageContext.request.contextPath}/product" class="button">Explore Now</a>
            </div>
        </section>

        <!----Card section ---->

        <section class="features">

            <div class="feature-row">
                <div class="feature-box">
                    <h3>P</h3>
                    <h4>Remote Management</h4>
                    <p>Control all your printers from anywhere. Monitor status, ink levels, and print jobs with
                        real-time updates.</p>
                </div>

                <div class="feature-box">
                    <h3>S</h3>
                    <h4>Smart Queueing</h4>
                    <p>Intelligent job prioritization ensures critical documents are printed first, optimizing workflow
                        efficiency.</p>
                </div>

                <div class="feature-box">
                    <h3>C</h3>
                    <h4>Cloud Integration</h4>
                    <p>Seamlessly connect with your favorite cloud services for effortless printing from Google Drive,
                        Dropbox, and more.</p>
                </div>
            </div>

            <div class="feature-row">
                <div class="feature-box">
                    <h3>A</h3>
                    <h4>Analytics Dashboard</h4>
                    <p>Comprehensive usage statistics and insights to optimize your printing resources and reduce costs.
                    </p>
                </div>

                <div class="feature-box">
                    <h3>M</h3>
                    <h4>Mobile Printing</h4>
                    <p>Print directly from any iOS or Android device with our intuitive mobile app experience.</p>
                </div>

                <div class="feature-box">
                    <h3>S</h3>
                    <h4>Secure Printing</h4>
                    <p>Enhanced security features with user authentication and encrypted data transmission.</p>
                </div>
            </div>
        </section>

        <!----Banner Image section ---->

        <section class="banner-section">
            <div class="banner-text">
                <h2>One interface. All devices.</h2>
                <p>PrinterOS works seamlessly across your entire fleet of printers,<br>regardless of brand or model.</p>
            </div>
            <div class="banner-image">
            </div>
        </section>


        <!-- Metrics Section -->
        <section class="data">
            <div>
                <h1>45%</h1>
                <p>Reduced waste</p>
            </div>
            <div>
                <h1>99.9%</h1>
                <p>Uptime reliability</p>
            </div>
            <div>
                <h1>30%</h1>
                <p>Cost savings</p>
            </div>
            <div>
                <h1>5M+</h1>
                <p>Users worldwide</p>
            </div>
        </section>

        <section class="cta">
            <h3>Ready to transform your printing experience?</h3>
            <p>Join thousands of businesses already enjoying the simplicity and <br> power of PrinterOS.</p>
            <a href="${pageContext.request.contextPath}/contact" class="btn">Contact Us</a>
        </section>

        <%@ include file="/WEB-INF/Pages/Footer.jsp" %>

</body>

</html>
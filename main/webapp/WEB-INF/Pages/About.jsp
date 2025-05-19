<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>About Us</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/About.css">
    </head>

    <body>

        <%@ include file="/WEB-INF/Pages/Header.jsp" %>

            <section class="story">
                <div class="txt">
                    <h1>Our Story</h1>
                    <p>We are reimagining printer management for the modern workspace, simple, intuitive, and powerful.
                    </p>
                </div>
            </section>


            <!-- Our Values Section -->
            <section class="values">
                <h2>Our Values</h2>
                <div class="value-row">
                    <div class="value-box">
                        <h3>S</h3>
                        <h4>Simplicity</h4>
                        <p>We believe technology should simplify work, not complicate it. Every feature we build starts
                            with the question:
                            How can we make this simpler?</p>
                    </div>

                    <div class="value-box">
                        <h3>I</h3>
                        <h4>Innovation</h4>
                        <p>We're constantly pushing boundaries to create solutions that transform how businesses manage
                            their printing infrastructure.</p>
                    </div>

                    <div class="value-box">
                        <h3>S</h3>
                        <h4>Sustainability</h4>
                        <p>We're committed to helping businesses reduce waste and energy consumption through smarter
                            printing practices.</p>
                    </div>
                </div>

            </section>

            <section class="origin">
                <div class="content">
                    <div class="image">
                        <img src="${pageContext.request.contextPath}/Resources/About/aboutus.png" alt="image">
                    </div>
                    <div class="origin-text">
                        <h2>How it all began</h2>
                        <p>Chapou was born out of frustration. In 2019, our founders were working at a global enterprise
                            where printer management
                            was a constant headache - complex interfaces, compatibility issues, and endless IT tickets.
                        </p>

                        <p>They asked a simple question: Why can't printer management be as intuitive as modern consumer
                            apps? This question sparked
                            a journey to reimagine enterprise printing from the ground up.</p>

                        <p>Today, Chapou serves thousands of businesses worldwide, from small startups to Fortune 500
                            companies, all united by the
                            desire for printing infrastructure that just works.</p>
                    </div>
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
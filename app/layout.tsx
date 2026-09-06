import type { Metadata } from "next";
import { Geist, Geist_Mono, Playfair_Display } from "next/font/google";
import "./globals.css";
import NavbarWrapper from "../components/NavbarWrapper";
import Footer from "../components/Footer";
import { generateOrganizationJsonLd } from "../lib/seo";
import AnalyticsTracker from "../components/AnalyticsTracker";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

const playfair = Playfair_Display({
  variable: "--font-playfair",
  subsets: ["latin"],
  weight: ["400", "500", "600", "700", "800", "900"],
});

export const metadata: Metadata = {
  title: "Fb5Star - Luxury High-End Fashion & Designer Clothing",
  description: "Discover luxury high-end fashion at Fb5Star. Shop premium designer clothing, elegant dresses, sophisticated accessories, and timeless pieces crafted for the modern wardrobe.",
  keywords: "luxury fashion, high-end clothing, designer wear, premium apparel, elegant dresses, sophisticated style, luxury brand, designer fashion, exclusive clothing, Fb5Star",
  authors: [{ name: "Fb5Star" }],
  openGraph: {
    title: "Fb5Star - Luxury High-End Fashion & Designer Clothing",
    description: "Discover luxury high-end fashion at Fb5Star. Shop premium designer clothing, elegant dresses, sophisticated accessories, and timeless pieces.",
    url: "https://Fb5Star.com",
    siteName: "Fb5Star",
    images: [{ url: "/og-image.jpg", width: 1200, height: 630 }],
    locale: "en_US",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Fb5Star - Luxury High-End Fashion",
    description: "Shop premium designer clothing and luxury fashion at Fb5Star",
    images: ["/og-image.jpg"],
  },
  icons: {
    icon: "/favicon.png",
    shortcut: "/favicon.png",
    apple: "/favicon.png",
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-video-preview": -1,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const organizationJsonLd = generateOrganizationJsonLd();
  
  return (
    <html lang="en">
      <head>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(organizationJsonLd) }}
        />
      </head>
      <body
        className={`${geistSans.variable} ${geistMono.variable} ${playfair.variable} antialiased`}
      >
        <AnalyticsTracker />
        <NavbarWrapper />
        {children}
        <Footer />
      </body>
    </html>
  );
}

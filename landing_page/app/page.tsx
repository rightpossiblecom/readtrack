import { Navbar } from "../components/layout/Navbar";
import { Hero } from "../components/landing/Hero";
import { Features } from "../components/landing/Features";
import { HowItWorks } from "../components/landing/HowItWorks";
import { FAQ } from "../components/landing/FAQ";
import { Footer } from "../components/landing/Footer";

export default function Home() {
  return (
    <div className="min-h-screen bg-white">
      <Navbar />
      <main>
        <Hero />
        <Features />
        <HowItWorks />
        <FAQ />

        {/* Bottom CTA */}
        <section className="py-24 bg-blue-600 text-center relative overflow-hidden">
          <div className="max-w-4xl mx-auto px-4 sm:px-6 z-10 relative">
            <h2 className="text-4xl md:text-5xl font-extrabold text-white mb-6">Start building your reading habit today</h2>
            <p className="text-xl text-blue-100 mb-10 max-w-2xl mx-auto">
              Download ReadTrack for free and join thousands of readers focusing on consistency over volume.
            </p>
            <div className="flex flex-col sm:flex-row justify-center gap-4">
              <button className="px-8 py-4 bg-white text-blue-600 font-bold rounded-full hover:bg-gray-50 transition-colors shadow-lg shadow-blue-900/20 text-lg">
                Download for Android
              </button>
              <button className="px-8 py-4 bg-blue-700 text-white font-bold rounded-full hover:bg-blue-800 transition-colors border border-blue-500 hover:border-blue-400 text-lg">
                Download for iOS
              </button>
            </div>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
}

export function AppScreen() {
    return (
        <div className="relative mx-auto border-gray-100 border-[8px] bg-white rounded-[2.5rem] h-[600px] w-full max-w-[300px] shadow-2xl overflow-hidden shadow-blue-900/10">
            {/* Mockup Top Bar */}
            <div className="absolute top-0 inset-x-0 h-6 bg-white flex justify-center pt-2">
                <div className="w-16 h-4 bg-gray-200 rounded-full"></div>
            </div>

            <div className="pt-12 px-6 h-full flex flex-col items-center">
                {/* Date and Streak */}
                <div className="w-full flex justify-between items-center mb-10 mt-4">
                    <span className="text-gray-500 font-medium">Today</span>
                    <div className="flex items-center gap-1 bg-orange-50 px-3 py-1 rounded-full">
                        <span className="text-orange-500 font-bold">12 🔥</span>
                    </div>
                </div>

                {/* Big Number Display */}
                <div className="text-center mb-10 w-full relative">
                    <svg className="absolute inset-0 w-full h-full -rotate-90 pointer-events-none" viewBox="0 0 100 100">
                        <circle cx="50" cy="50" r="45" fill="none" stroke="#f1f5f9" strokeWidth="6" />
                        <circle cx="50" cy="50" r="45" fill="none" stroke="#3b82f6" strokeWidth="6" strokeDasharray="283" strokeDashoffset="50" className="transition-all duration-1000 ease-out" />
                    </svg>
                    <div className="w-48 h-48 mx-auto flex flex-col items-center justify-center bg-white rounded-full">
                        <h2 className="text-6xl font-black text-gray-900">25</h2>
                        <p className="text-gray-400 font-medium mt-1">minutes so far</p>
                    </div>
                </div>

                {/* Action Button */}
                <button className="w-full py-4 rounded-2xl bg-gray-900 text-white font-bold text-lg mb-8 shadow-md">
                    Log Reading
                </button>

                {/* Weekly Progress */}
                <div className="w-full mt-auto mb-6 bg-gray-50 p-4 rounded-2xl">
                    <p className="text-xs font-semibold text-gray-400 mb-3 uppercase tracking-wider text-center">This Week</p>
                    <div className="flex justify-between items-end gap-1 px-2 h-16">
                        <div className="w-1/7 flex flex-col items-center gap-1"><div className="w-full bg-blue-500 rounded-t h-12"></div><span className="text-[10px] text-gray-400">M</span></div>
                        <div className="w-1/7 flex flex-col items-center gap-1"><div className="w-full bg-blue-500 rounded-t h-8"></div><span className="text-[10px] text-gray-400">T</span></div>
                        <div className="w-1/7 flex flex-col items-center gap-1"><div className="w-full bg-blue-500 rounded-t h-16"></div><span className="text-[10px] text-gray-400">W</span></div>
                        <div className="w-1/7 flex flex-col items-center gap-1"><div className="w-full bg-gray-200 rounded-t h-1"></div><span className="text-[10px] text-gray-400">T</span></div>
                        <div className="w-1/7 flex flex-col items-center gap-1"><div className="w-full bg-blue-500 rounded-t h-10"></div><span className="text-[10px] text-gray-400">F</span></div>
                        <div className="w-1/7 flex flex-col items-center gap-1"><div className="w-full bg-blue-500 rounded-t h-14"></div><span className="text-[10px] text-gray-400">S</span></div>
                        <div className="w-1/7 flex flex-col items-center gap-1"><div className="w-full bg-gray-200 rounded-t h-1"></div><span className="text-[10px] text-gray-400">S</span></div>
                    </div>
                </div>
            </div>
        </div>
    );
}

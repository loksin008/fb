import tkinter as tk
import time

class StopwatchApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Stopwatch")

        # Stopwatch Variables
        self.running = False
        self.counter = 0

        # Create GUI Elements
        self.time_label = tk.Label(root, text="00:00:00", font=("Helvetica", 36))
        self.time_label.pack(pady=20)

        # Control Buttons
        self.start_button = tk.Button(root, text="Start", font=("Helvetica", 14), command=self.start)
        self.start_button.pack(side=tk.LEFT, padx=10)
        
        self.stop_button = tk.Button(root, text="Stop", font=("Helvetica", 14), command=self.stop)
        self.stop_button.pack(side=tk.LEFT, padx=10)
        
        self.reset_button = tk.Button(root, text="Reset", font=("Helvetica", 14), command=self.reset)
        self.reset_button.pack(side=tk.LEFT, padx=10)

        # Navigation Buttons
        self.back_button = tk.Button(root, text="Back", font=("Helvetica", 14), command=self.back)
        self.back_button.pack(side=tk.RIGHT, padx=10)
        
        self.exit_button = tk.Button(root, text="Exit", font=("Helvetica", 14), command=root.quit)
        self.exit_button.pack(side=tk.RIGHT, padx=10)

    def update_time(self):
        if self.running:
            self.counter += 1
            time_str = time.strftime("%H:%M:%S", time.gmtime(self.counter))
            self.time_label.config(text=time_str)
            self.root.after(1000, self.update_time)

    def start(self):
        if not self.running:
            self.running = True
            self.update_time()

    def stop(self):
        self.running = False

    def reset(self):
        self.counter = 0
        self.time_label.config(text="00:00:00")
        self.running = False

    def back(self):
        self.reset()  # Stops and resets the stopwatch; customize as needed

# Main code to run the app
root = tk.Tk()
app = StopwatchApp(root)
root.mainloop()

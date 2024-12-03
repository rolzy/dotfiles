import base64
import os

from dotenv import load_dotenv
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

load_dotenv()

URL = "https://au.isolarcloud.com/"
USERNAME = os.getenv("USERNAME")
PASSWORD = os.getenv("PASSWORD")

options = Options()
options.add_argument("--headless")

# Setup driver and get URL
driver = webdriver.Firefox(options=options)
driver.get(URL)
print("Visit website")

# Find login field
driver.find_element("id", "userAcct").send_keys(USERNAME)
driver.find_element("id", "userPswd").send_keys(PASSWORD)

# Login
driver.find_element("id", "login-btn").click()
print("Sent login request")

# Wait for Privacy Policy to popup, click agree
wait = WebDriverWait(driver, 20)
wait.until(EC.element_to_be_clickable((By.CLASS_NAME, "privacy-agree"))).click()
print("Agreed on Privacy Policy")

# Wait until redirect is complete, then fetch today's yield
wait.until(EC.visibility_of_element_located((By.CSS_SELECTOR, ".data.big")))
today_yield = driver.find_element(By.CSS_SELECTOR, ".data.big").text
print(f"Got solar yield value. Yield = {today_yield}")

# Write the result to a file
with open("/home/rolzy/dotfiles/scripts/fetch-solar-data/result.txt", "w") as f:
    f.write(today_yield)
print("Wrote daily yield to file")

# Now move to the plant detail page
driver.find_element(By.CLASS_NAME, "plant-avatar").click()

# Wait for the daily production curve to display, then save the canvas as an image
wait.until(
    EC.visibility_of_element_located((By.XPATH, "//*[@id='chart']/div[1]/canvas"))
)
canvas = driver.find_element(By.XPATH, "//*[@id='chart']/div[1]/canvas")
print("Found daily yield chart")

# Get the canvas as a PNG image
canvas_base64 = driver.execute_script(
    "return arguments[0].toDataURL('image/png').substring(21);", canvas
)
canvas_png = base64.b64decode(canvas_base64)
with open("/home/rolzy/dotfiles/scripts/fetch-solar-data/canvas.png", "wb") as f:
    f.write(canvas_png)
print("Saved daily yield chart as file")

# Close the browser endpoint
driver.quit()

# 🍼 BabyGlow - Personalized Baby Skincare Recommendations

A beautiful, intuitive web application that helps mothers determine the best skincare products for their babies based on age, skin type, allergies, ethnicity, and personal preferences.

## ✨ Features

- **Age-Appropriate Recommendations**: Tailored suggestions from newborn to 2+ years
- **Skin Type Analysis**: Support for normal, dry, sensitive, eczema-prone, and combination skin
- **Allergy Awareness**: Considers both parent and child allergies to avoid harmful ingredients
- **Ethnicity-Specific Options**: Products formulated for different skin tones and types
- **Organic Options**: Filter for certified organic and natural products
- **International Brands**: Access to products from USA, France, Japan, Korea, Switzerland, and Australia
- **Smart Scoring**: Algorithm that ranks products based on your specific needs
- **Beautiful UI**: Warm, nurturing design with smooth animations

## 🌍 Product Database Includes

- **French**: Mustela, Bioderma, Weleda
- **American**: CeraVe, Aveeno, SheaMoisture, Earth Mama
- **Japanese**: Shiseido 2e Baby Plus
- **Korean**: Atopalm MLE
- **Australian**: Gaia Natural Baby
- **Swiss**: Weleda Calendula

## 🚀 Deploy to Vercel

### Option 1: Deploy via Vercel CLI (Recommended)

1. Install Vercel CLI globally:
   ```bash
   npm install -g vercel
   ```

2. Navigate to the project directory:
   ```bash
   cd baby-skincare-app
   ```

3. Login to Vercel:
   ```bash
   vercel login
   ```

4. Deploy:
   ```bash
   vercel
   ```

5. Follow the prompts and select your preferences

6. For production deployment:
   ```bash
   vercel --prod
   ```

### Option 2: Deploy via Vercel Dashboard

1. Push your code to a Git repository (GitHub, GitLab, or Bitbucket)

2. Go to [vercel.com](https://vercel.com) and sign up/login

3. Click "Add New Project"

4. Import your Git repository

5. Vercel will automatically detect the framework (Vite) and configure build settings

6. Click "Deploy"

### Option 3: Deploy via Vercel GitHub Integration

1. Push this project to a GitHub repository

2. Go to [vercel.com](https://vercel.com) and connect your GitHub account

3. Select your repository

4. Vercel will auto-configure and deploy

## 🛠️ Local Development

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start development server:
   ```bash
   npm run dev
   ```

3. Open your browser to `http://localhost:5173`

## 📦 Build for Production

```bash
npm run build
```

The built files will be in the `dist` directory.

## 🎨 Technology Stack

- **React 18**: Modern UI framework
- **Vite**: Fast build tool and dev server
- **Lucide React**: Beautiful icon library
- **Vanilla CSS**: Custom animations and styling

## 📱 Features Breakdown

### Step 1: Baby Information
- Age range selection (0-3 months to 2+ years)
- Skin type identification
- Ethnicity selection for targeted recommendations

### Step 2: Allergy Information
- Parent allergy tracking (genetic predisposition)
- Known baby allergies
- Avoids 10 common allergens including fragrance, parabens, sulfates, etc.

### Step 3: Preferences
- Organic product preference toggle
- International brand inclusion toggle

### Step 4: Recommendations
- Top 5 personalized product matches
- Match score (0-100%)
- Detailed ingredient information
- Regional origin
- "Free from" allergen list
- Price indicator
- Why it's recommended

## 🔒 Safety Features

- Patch test reminder
- Pediatrician consultation note
- Clear allergen avoidance
- Age-appropriate formulations

## 🎯 Product Scoring Algorithm

The app uses a sophisticated scoring system that considers:
- Age appropriateness (40 points)
- Skin type matching (20-30 points)
- Allergen avoidance (50 points)
- Organic preference (25 points)
- International availability (60 points)
- Ethnicity-specific formulation (10 points)

## 📝 License

This project is open source and available for personal and commercial use.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## 💖 About

Created with love for mothers everywhere who want the best for their babies' delicate skin.

---

**Note**: This app provides recommendations based on general product information. Always consult with your pediatrician or dermatologist before introducing new skincare products, especially for babies with sensitive skin or allergies.

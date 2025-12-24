import React, { useState } from 'react';
import { Droplet, Baby, Heart, Leaf, Globe, AlertCircle, ChevronRight, Sparkles } from 'lucide-react';

const BabySkincareApp = () => {
  const [formData, setFormData] = useState({
    babyAge: '',
    skinType: '',
    parentAllergies: [],
    childAllergies: [],
    ethnicity: '',
    preferOrganic: false,
    includeInternational: false
  });
  
  const [recommendations, setRecommendations] = useState(null);
  const [step, setStep] = useState(1);

  const skinTypes = [
    { value: 'normal', label: 'Normal', desc: 'Balanced, no major concerns' },
    { value: 'dry', label: 'Dry', desc: 'Flaky, tight, or rough patches' },
    { value: 'sensitive', label: 'Sensitive', desc: 'Easily irritated, red, or reactive' },
    { value: 'eczema', label: 'Eczema-prone', desc: 'Patches of dry, itchy skin' },
    { value: 'combination', label: 'Combination', desc: 'Mix of dry and normal areas' }
  ];

  const ageRanges = [
    { value: '0-3', label: 'Newborn (0-3 months)' },
    { value: '3-6', label: '3-6 months' },
    { value: '6-12', label: '6-12 months' },
    { value: '12-24', label: '1-2 years' },
    { value: '24+', label: '2+ years' }
  ];

  const commonAllergens = [
    'Fragrance', 'Parabens', 'Sulfates', 'Dyes', 'Lanolin', 
    'Formaldehyde', 'Phthalates', 'Mineral Oil', 'Petrolatum', 'Nuts'
  ];

  const ethnicities = [
    { value: 'african', label: 'African/African American' },
    { value: 'asian', label: 'Asian' },
    { value: 'caucasian', label: 'Caucasian' },
    { value: 'hispanic', label: 'Hispanic/Latino' },
    { value: 'middle-eastern', label: 'Middle Eastern' },
    { value: 'mixed', label: 'Mixed ethnicity' },
    { value: 'other', label: 'Other/Prefer not to say' }
  ];

  const productDatabase = {
    'newborn-sensitive': {
      name: 'Mustela Stelatopia Emollient Cream',
      region: 'France',
      organic: true,
      ingredients: 'Sunflower oil distillate, glycerin, shea butter',
      suitable: ['0-3', '3-6'],
      avoids: ['Fragrance', 'Parabens'],
      ethnicity: 'all',
      price: '$$',
      why: 'Specifically formulated for newborn eczema-prone skin with clinically proven results'
    },
    'moisturizer-dry': {
      name: 'Weleda Calendula Baby Cream',
      region: 'Switzerland',
      organic: true,
      ingredients: 'Calendula extract, almond oil, beeswax',
      suitable: ['0-3', '3-6', '6-12'],
      avoids: ['Parabens', 'Sulfates', 'Dyes'],
      ethnicity: 'all',
      price: '$',
      why: 'Gentle botanical formula that protects and soothes delicate skin'
    },
    'eczema-treatment': {
      name: 'Aveeno Baby Eczema Therapy',
      region: 'USA',
      organic: false,
      ingredients: 'Colloidal oatmeal, ceramides, glycerin',
      suitable: ['3-6', '6-12', '12-24', '24+'],
      avoids: ['Fragrance', 'Parabens', 'Phthalates'],
      ethnicity: 'all',
      price: '$$',
      why: 'Dermatologist-recommended for managing eczema flare-ups'
    },
    'daily-moisturizer': {
      name: 'CeraVe Baby Moisturizing Cream',
      region: 'USA',
      organic: false,
      ingredients: 'Ceramides, hyaluronic acid, niacinamide',
      suitable: ['6-12', '12-24', '24+'],
      avoids: ['Fragrance', 'Parabens'],
      ethnicity: 'all',
      price: '$',
      why: 'Developed with dermatologists, restores skin barrier'
    },
    'melanin-rich': {
      name: 'SheaMoisture Baby Eczema Therapy',
      region: 'USA',
      organic: true,
      ingredients: 'Raw shea butter, colloidal oatmeal, frankincense',
      suitable: ['3-6', '6-12', '12-24', '24+'],
      avoids: ['Sulfates', 'Parabens', 'Mineral Oil'],
      ethnicity: ['african', 'mixed'],
      price: '$$',
      why: 'Specially formulated for melanin-rich skin with extra moisture'
    },
    'japanese-gentle': {
      name: 'Shiseido 2e Baby Plus Emulsion',
      region: 'Japan',
      organic: false,
      ingredients: 'Hypoallergenic mineral water, glycerin',
      suitable: ['0-3', '3-6', '6-12'],
      avoids: ['Fragrance', 'Dyes', 'Parabens', 'Mineral Oil'],
      ethnicity: ['asian', 'all'],
      price: '$$$',
      why: 'Ultra-gentle Japanese formula for highly sensitive skin'
    },
    'korean-moisture': {
      name: 'Atopalm MLE Cream',
      region: 'Korea',
      organic: false,
      ingredients: 'Multi-lamellar emulsion, ceramides, beta-glucan',
      suitable: ['3-6', '6-12', '12-24', '24+'],
      avoids: ['Fragrance', 'Parabens', 'Sulfates'],
      ethnicity: 'all',
      price: '$$$',
      why: 'Korean technology that mimics skin barrier structure'
    },
    'organic-all-purpose': {
      name: 'Earth Mama Organic Baby Lotion',
      region: 'USA',
      organic: true,
      ingredients: 'Organic calendula, organic shea butter, organic coconut oil',
      suitable: ['6-12', '12-24', '24+'],
      avoids: ['Fragrance', 'Parabens', 'Sulfates', 'Dyes'],
      ethnicity: 'all',
      price: '$$',
      why: 'USDA certified organic with pure plant-based ingredients'
    },
    'french-protective': {
      name: 'Bioderma ABCDerm Cold-Cream',
      region: 'France',
      organic: false,
      ingredients: 'Glycerin, beeswax, shea butter',
      suitable: ['0-3', '3-6', '6-12', '12-24'],
      avoids: ['Parabens', 'Fragrance'],
      ethnicity: 'all',
      price: '$$',
      why: 'French pharmacy grade protection for very dry skin'
    },
    'australian-natural': {
      name: 'Gaia Natural Baby Cream',
      region: 'Australia',
      organic: true,
      ingredients: 'Organic calendula, organic chamomile, almond oil',
      suitable: ['0-3', '3-6', '6-12', '12-24', '24+'],
      avoids: ['Fragrance', 'Parabens', 'Sulfates', 'Mineral Oil'],
      ethnicity: 'all',
      price: '$$',
      why: 'Australian certified organic with calming botanicals'
    }
  };

  const handleInputChange = (field, value) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  const toggleAllergen = (allergen, type) => {
    setFormData(prev => {
      const field = type === 'parent' ? 'parentAllergies' : 'childAllergies';
      const current = prev[field];
      const updated = current.includes(allergen)
        ? current.filter(a => a !== allergen)
        : [...current, allergen];
      return { ...prev, [field]: updated };
    });
  };

  const getRecommendations = () => {
    const allAllergens = [...new Set([...formData.parentAllergies, ...formData.childAllergies])];
    
    let scored = Object.entries(productDatabase).map(([key, product]) => {
      let score = 100;
      
      // Age appropriateness
      if (!product.suitable.includes(formData.babyAge)) {
        score -= 40;
      }
      
      // Skin type matching
      if (formData.skinType === 'eczema' && key.includes('eczema')) {
        score += 30;
      } else if (formData.skinType === 'dry' && (key.includes('moisturizer') || key.includes('cream'))) {
        score += 20;
      } else if (formData.skinType === 'sensitive' && (product.avoids.length >= 3)) {
        score += 20;
      }
      
      // Allergen avoidance
      const hasAllergen = allAllergens.some(allergen => 
        !product.avoids.includes(allergen)
      );
      if (hasAllergen) {
        score -= 50;
      }
      
      // Organic preference
      if (formData.preferOrganic && product.organic) {
        score += 25;
      } else if (formData.preferOrganic && !product.organic) {
        score -= 15;
      }
      
      // International products
      if (!formData.includeInternational && product.region !== 'USA') {
        score -= 60;
      }
      
      // Ethnicity matching
      if (Array.isArray(product.ethnicity) && !product.ethnicity.includes(formData.ethnicity)) {
        score -= 10;
      }
      
      return { ...product, key, score };
    });
    
    scored.sort((a, b) => b.score - a.score);
    
    setRecommendations(scored.slice(0, 5));
  };

  const handleSubmit = () => {
    getRecommendations();
    setStep(4);
  };

  const resetForm = () => {
    setFormData({
      babyAge: '',
      skinType: '',
      parentAllergies: [],
      childAllergies: [],
      ethnicity: '',
      preferOrganic: false,
      includeInternational: false
    });
    setRecommendations(null);
    setStep(1);
  };

  return (
    <div style={{
      minHeight: '100vh',
      background: 'linear-gradient(135deg, #fef4f1 0%, #fce8e0 25%, #f9e5dd 50%, #fff9f5 100%)',
      fontFamily: '"Nunito", "Quicksand", -apple-system, sans-serif',
      padding: '20px',
      position: 'relative',
      overflow: 'hidden'
    }}>
      {/* Decorative background elements */}
      <div style={{
        position: 'absolute',
        top: '-100px',
        right: '-100px',
        width: '400px',
        height: '400px',
        background: 'radial-gradient(circle, rgba(255,182,193,0.15) 0%, transparent 70%)',
        borderRadius: '50%',
        pointerEvents: 'none'
      }} />
      <div style={{
        position: 'absolute',
        bottom: '-150px',
        left: '-150px',
        width: '500px',
        height: '500px',
        background: 'radial-gradient(circle, rgba(176,224,230,0.12) 0%, transparent 70%)',
        borderRadius: '50%',
        pointerEvents: 'none'
      }} />

      <div style={{
        maxWidth: '900px',
        margin: '0 auto',
        position: 'relative'
      }}>
        {/* Header */}
        <div style={{
          textAlign: 'center',
          marginBottom: '50px',
          animation: 'fadeInDown 0.8s ease-out'
        }}>
          <div style={{
            display: 'inline-flex',
            alignItems: 'center',
            gap: '12px',
            marginBottom: '15px'
          }}>
            <Droplet style={{ color: '#ff9fb8', strokeWidth: 2.5 }} size={36} />
            <h1 style={{
              margin: 0,
              fontSize: '42px',
              fontWeight: '800',
              background: 'linear-gradient(135deg, #ff8fa3 0%, #ffb6c1 50%, #ffc4d0 100%)',
              WebkitBackgroundClip: 'text',
              WebkitTextFillColor: 'transparent',
              letterSpacing: '-0.5px'
            }}>
              BabyGlow
            </h1>
          </div>
          <p style={{
            fontSize: '18px',
            color: '#8b7d7d',
            margin: 0,
            fontWeight: '500'
          }}>
            Personalized skincare recommendations for your precious one
          </p>
        </div>

        {/* Progress indicator */}
        {step <= 3 && (
          <div style={{
            display: 'flex',
            gap: '12px',
            marginBottom: '40px',
            justifyContent: 'center'
          }}>
            {[1, 2, 3].map(s => (
              <div key={s} style={{
                width: step === s ? '60px' : '40px',
                height: '8px',
                background: step >= s 
                  ? 'linear-gradient(90deg, #ff9fb8, #ffc4d0)' 
                  : 'rgba(255,159,184,0.2)',
                borderRadius: '20px',
                transition: 'all 0.4s cubic-bezier(0.4, 0, 0.2, 1)',
                boxShadow: step >= s ? '0 2px 8px rgba(255,159,184,0.3)' : 'none'
              }} />
            ))}
          </div>
        )}

        {/* Main Card */}
        <div style={{
          background: 'rgba(255, 255, 255, 0.85)',
          backdropFilter: 'blur(20px)',
          borderRadius: '32px',
          padding: '50px',
          boxShadow: '0 20px 60px rgba(255,159,184,0.15), 0 0 0 1px rgba(255,255,255,0.8)',
          border: '1px solid rgba(255,255,255,0.9)',
          animation: 'fadeInUp 0.6s ease-out'
        }}>
          {/* Step 1: Baby Info */}
          {step === 1 && (
            <div style={{ animation: 'fadeIn 0.5s ease-out' }}>
              <div style={{
                display: 'flex',
                alignItems: 'center',
                gap: '12px',
                marginBottom: '30px'
              }}>
                <div style={{
                  background: 'linear-gradient(135deg, #fff0f5, #ffe8f0)',
                  padding: '12px',
                  borderRadius: '16px',
                  display: 'flex',
                  boxShadow: '0 4px 12px rgba(255,159,184,0.15)'
                }}>
                  <Baby style={{ color: '#ff9fb8' }} size={28} />
                </div>
                <h2 style={{
                  margin: 0,
                  fontSize: '28px',
                  color: '#6b5b5b',
                  fontWeight: '700'
                }}>
                  Tell us about your baby
                </h2>
              </div>

              <div style={{ marginBottom: '30px' }}>
                <label style={{
                  display: 'block',
                  marginBottom: '12px',
                  fontSize: '16px',
                  fontWeight: '600',
                  color: '#8b7d7d'
                }}>
                  Baby's Age Range
                </label>
                <div style={{
                  display: 'grid',
                  gridTemplateColumns: 'repeat(auto-fit, minmax(140px, 1fr))',
                  gap: '12px'
                }}>
                  {ageRanges.map(age => (
                    <button
                      key={age.value}
                      onClick={() => handleInputChange('babyAge', age.value)}
                      style={{
                        padding: '18px',
                        background: formData.babyAge === age.value
                          ? 'linear-gradient(135deg, #ff9fb8, #ffb6c1)'
                          : 'white',
                        color: formData.babyAge === age.value ? 'white' : '#8b7d7d',
                        border: formData.babyAge === age.value 
                          ? 'none' 
                          : '2px solid rgba(255,159,184,0.3)',
                        borderRadius: '16px',
                        cursor: 'pointer',
                        fontWeight: '600',
                        fontSize: '14px',
                        transition: 'all 0.3s ease',
                        boxShadow: formData.babyAge === age.value 
                          ? '0 6px 20px rgba(255,159,184,0.3)' 
                          : '0 2px 8px rgba(0,0,0,0.05)',
                        transform: formData.babyAge === age.value ? 'translateY(-2px)' : 'none'
                      }}
                    >
                      {age.label}
                    </button>
                  ))}
                </div>
              </div>

              <div style={{ marginBottom: '30px' }}>
                <label style={{
                  display: 'block',
                  marginBottom: '12px',
                  fontSize: '16px',
                  fontWeight: '600',
                  color: '#8b7d7d'
                }}>
                  Skin Type
                </label>
                <div style={{
                  display: 'grid',
                  gridTemplateColumns: 'repeat(auto-fit, minmax(150px, 1fr))',
                  gap: '12px'
                }}>
                  {skinTypes.map(type => (
                    <button
                      key={type.value}
                      onClick={() => handleInputChange('skinType', type.value)}
                      style={{
                        padding: '16px',
                        background: formData.skinType === type.value
                          ? 'linear-gradient(135deg, #ff9fb8, #ffb6c1)'
                          : 'white',
                        color: formData.skinType === type.value ? 'white' : '#8b7d7d',
                        border: formData.skinType === type.value 
                          ? 'none' 
                          : '2px solid rgba(255,159,184,0.3)',
                        borderRadius: '16px',
                        cursor: 'pointer',
                        fontWeight: '600',
                        fontSize: '14px',
                        textAlign: 'left',
                        transition: 'all 0.3s ease',
                        boxShadow: formData.skinType === type.value 
                          ? '0 6px 20px rgba(255,159,184,0.3)' 
                          : '0 2px 8px rgba(0,0,0,0.05)',
                        transform: formData.skinType === type.value ? 'translateY(-2px)' : 'none'
                      }}
                    >
                      <div style={{ fontWeight: '700', marginBottom: '4px' }}>{type.label}</div>
                      <div style={{
                        fontSize: '12px',
                        opacity: formData.skinType === type.value ? 0.9 : 0.7
                      }}>
                        {type.desc}
                      </div>
                    </button>
                  ))}
                </div>
              </div>

              <div style={{ marginBottom: '30px' }}>
                <label style={{
                  display: 'block',
                  marginBottom: '12px',
                  fontSize: '16px',
                  fontWeight: '600',
                  color: '#8b7d7d'
                }}>
                  Ethnicity (helps us recommend appropriate products)
                </label>
                <select
                  value={formData.ethnicity}
                  onChange={(e) => handleInputChange('ethnicity', e.target.value)}
                  style={{
                    width: '100%',
                    padding: '16px',
                    fontSize: '15px',
                    border: '2px solid rgba(255,159,184,0.3)',
                    borderRadius: '16px',
                    background: 'white',
                    color: '#8b7d7d',
                    fontWeight: '600',
                    cursor: 'pointer',
                    fontFamily: 'inherit'
                  }}
                >
                  <option value="">Select ethnicity...</option>
                  {ethnicities.map(eth => (
                    <option key={eth.value} value={eth.value}>{eth.label}</option>
                  ))}
                </select>
              </div>

              <button
                onClick={() => setStep(2)}
                disabled={!formData.babyAge || !formData.skinType || !formData.ethnicity}
                style={{
                  width: '100%',
                  padding: '18px',
                  background: formData.babyAge && formData.skinType && formData.ethnicity
                    ? 'linear-gradient(135deg, #ff9fb8, #ffb6c1)'
                    : 'rgba(255,159,184,0.3)',
                  color: 'white',
                  border: 'none',
                  borderRadius: '16px',
                  fontSize: '16px',
                  fontWeight: '700',
                  cursor: formData.babyAge && formData.skinType && formData.ethnicity ? 'pointer' : 'not-allowed',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  gap: '10px',
                  boxShadow: formData.babyAge && formData.skinType && formData.ethnicity 
                    ? '0 8px 24px rgba(255,159,184,0.4)' 
                    : 'none',
                  transition: 'all 0.3s ease',
                  transform: formData.babyAge && formData.skinType && formData.ethnicity ? 'none' : 'scale(0.98)'
                }}
              >
                Continue to Allergies
                <ChevronRight size={20} />
              </button>
            </div>
          )}

          {/* Step 2: Allergies */}
          {step === 2 && (
            <div style={{ animation: 'fadeIn 0.5s ease-out' }}>
              <div style={{
                display: 'flex',
                alignItems: 'center',
                gap: '12px',
                marginBottom: '30px'
              }}>
                <div style={{
                  background: 'linear-gradient(135deg, #fff0f5, #ffe8f0)',
                  padding: '12px',
                  borderRadius: '16px',
                  display: 'flex',
                  boxShadow: '0 4px 12px rgba(255,159,184,0.15)'
                }}>
                  <AlertCircle style={{ color: '#ff9fb8' }} size={28} />
                </div>
                <h2 style={{
                  margin: 0,
                  fontSize: '28px',
                  color: '#6b5b5b',
                  fontWeight: '700'
                }}>
                  Allergy Information
                </h2>
              </div>

              <div style={{
                background: 'rgba(255,235,245,0.4)',
                padding: '18px',
                borderRadius: '16px',
                marginBottom: '30px',
                border: '1px solid rgba(255,159,184,0.2)'
              }}>
                <p style={{
                  margin: 0,
                  fontSize: '14px',
                  color: '#8b7d7d',
                  lineHeight: '1.6'
                }}>
                  Select any known allergies to help us avoid products with those ingredients. Family history matters!
                </p>
              </div>

              <div style={{ marginBottom: '30px' }}>
                <label style={{
                  display: 'block',
                  marginBottom: '16px',
                  fontSize: '16px',
                  fontWeight: '600',
                  color: '#8b7d7d'
                }}>
                  Parent Allergies (yours or partner's)
                </label>
                <div style={{
                  display: 'flex',
                  flexWrap: 'wrap',
                  gap: '10px'
                }}>
                  {commonAllergens.map(allergen => (
                    <button
                      key={`parent-${allergen}`}
                      onClick={() => toggleAllergen(allergen, 'parent')}
                      style={{
                        padding: '10px 18px',
                        background: formData.parentAllergies.includes(allergen)
                          ? 'linear-gradient(135deg, #ffb6c1, #ffc4d0)'
                          : 'white',
                        color: formData.parentAllergies.includes(allergen) ? 'white' : '#8b7d7d',
                        border: formData.parentAllergies.includes(allergen) 
                          ? 'none' 
                          : '2px solid rgba(255,159,184,0.3)',
                        borderRadius: '25px',
                        cursor: 'pointer',
                        fontWeight: '600',
                        fontSize: '13px',
                        transition: 'all 0.3s ease',
                        boxShadow: formData.parentAllergies.includes(allergen) 
                          ? '0 4px 12px rgba(255,159,184,0.3)' 
                          : 'none'
                      }}
                    >
                      {allergen}
                    </button>
                  ))}
                </div>
              </div>

              <div style={{ marginBottom: '30px' }}>
                <label style={{
                  display: 'block',
                  marginBottom: '16px',
                  fontSize: '16px',
                  fontWeight: '600',
                  color: '#8b7d7d'
                }}>
                  Known Baby Allergies
                </label>
                <div style={{
                  display: 'flex',
                  flexWrap: 'wrap',
                  gap: '10px'
                }}>
                  {commonAllergens.map(allergen => (
                    <button
                      key={`child-${allergen}`}
                      onClick={() => toggleAllergen(allergen, 'child')}
                      style={{
                        padding: '10px 18px',
                        background: formData.childAllergies.includes(allergen)
                          ? 'linear-gradient(135deg, #ff9fb8, #ffb6c1)'
                          : 'white',
                        color: formData.childAllergies.includes(allergen) ? 'white' : '#8b7d7d',
                        border: formData.childAllergies.includes(allergen) 
                          ? 'none' 
                          : '2px solid rgba(255,159,184,0.3)',
                        borderRadius: '25px',
                        cursor: 'pointer',
                        fontWeight: '600',
                        fontSize: '13px',
                        transition: 'all 0.3s ease',
                        boxShadow: formData.childAllergies.includes(allergen) 
                          ? '0 4px 12px rgba(255,159,184,0.3)' 
                          : 'none'
                      }}
                    >
                      {allergen}
                    </button>
                  ))}
                </div>
              </div>

              <div style={{
                display: 'flex',
                gap: '12px'
              }}>
                <button
                  onClick={() => setStep(1)}
                  style={{
                    flex: 1,
                    padding: '18px',
                    background: 'white',
                    color: '#8b7d7d',
                    border: '2px solid rgba(255,159,184,0.3)',
                    borderRadius: '16px',
                    fontSize: '16px',
                    fontWeight: '700',
                    cursor: 'pointer',
                    transition: 'all 0.3s ease'
                  }}
                >
                  Back
                </button>
                <button
                  onClick={() => setStep(3)}
                  style={{
                    flex: 2,
                    padding: '18px',
                    background: 'linear-gradient(135deg, #ff9fb8, #ffb6c1)',
                    color: 'white',
                    border: 'none',
                    borderRadius: '16px',
                    fontSize: '16px',
                    fontWeight: '700',
                    cursor: 'pointer',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    gap: '10px',
                    boxShadow: '0 8px 24px rgba(255,159,184,0.4)',
                    transition: 'all 0.3s ease'
                  }}
                >
                  Continue to Preferences
                  <ChevronRight size={20} />
                </button>
              </div>
            </div>
          )}

          {/* Step 3: Preferences */}
          {step === 3 && (
            <div style={{ animation: 'fadeIn 0.5s ease-out' }}>
              <div style={{
                display: 'flex',
                alignItems: 'center',
                gap: '12px',
                marginBottom: '30px'
              }}>
                <div style={{
                  background: 'linear-gradient(135deg, #fff0f5, #ffe8f0)',
                  padding: '12px',
                  borderRadius: '16px',
                  display: 'flex',
                  boxShadow: '0 4px 12px rgba(255,159,184,0.15)'
                }}>
                  <Heart style={{ color: '#ff9fb8' }} size={28} />
                </div>
                <h2 style={{
                  margin: 0,
                  fontSize: '28px',
                  color: '#6b5b5b',
                  fontWeight: '700'
                }}>
                  Your Preferences
                </h2>
              </div>

              <div style={{ marginBottom: '25px' }}>
                <button
                  onClick={() => handleInputChange('preferOrganic', !formData.preferOrganic)}
                  style={{
                    width: '100%',
                    padding: '24px',
                    background: formData.preferOrganic 
                      ? 'linear-gradient(135deg, #98d8c8, #b4e5d4)'
                      : 'white',
                    color: formData.preferOrganic ? 'white' : '#8b7d7d',
                    border: formData.preferOrganic ? 'none' : '2px solid rgba(152,216,200,0.4)',
                    borderRadius: '20px',
                    cursor: 'pointer',
                    textAlign: 'left',
                    transition: 'all 0.3s ease',
                    boxShadow: formData.preferOrganic 
                      ? '0 8px 24px rgba(152,216,200,0.3)' 
                      : '0 2px 8px rgba(0,0,0,0.05)',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '16px'
                  }}
                >
                  <div style={{
                    background: formData.preferOrganic ? 'rgba(255,255,255,0.3)' : 'rgba(152,216,200,0.1)',
                    padding: '12px',
                    borderRadius: '12px',
                    display: 'flex'
                  }}>
                    <Leaf size={28} />
                  </div>
                  <div style={{ flex: 1 }}>
                    <div style={{
                      fontWeight: '700',
                      fontSize: '18px',
                      marginBottom: '4px'
                    }}>
                      Prefer Organic Products
                    </div>
                    <div style={{
                      fontSize: '14px',
                      opacity: 0.9
                    }}>
                      Prioritize certified organic and natural ingredients
                    </div>
                  </div>
                  <div style={{
                    width: '24px',
                    height: '24px',
                    borderRadius: '50%',
                    background: formData.preferOrganic ? 'white' : 'transparent',
                    border: formData.preferOrganic ? 'none' : '2px solid rgba(152,216,200,0.5)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center'
                  }}>
                    {formData.preferOrganic && (
                      <div style={{
                        width: '10px',
                        height: '10px',
                        background: '#98d8c8',
                        borderRadius: '50%'
                      }} />
                    )}
                  </div>
                </button>
              </div>

              <div style={{ marginBottom: '30px' }}>
                <button
                  onClick={() => handleInputChange('includeInternational', !formData.includeInternational)}
                  style={{
                    width: '100%',
                    padding: '24px',
                    background: formData.includeInternational 
                      ? 'linear-gradient(135deg, #a8c0e8, #c0d4f5)'
                      : 'white',
                    color: formData.includeInternational ? 'white' : '#8b7d7d',
                    border: formData.includeInternational ? 'none' : '2px solid rgba(168,192,232,0.4)',
                    borderRadius: '20px',
                    cursor: 'pointer',
                    textAlign: 'left',
                    transition: 'all 0.3s ease',
                    boxShadow: formData.includeInternational 
                      ? '0 8px 24px rgba(168,192,232,0.3)' 
                      : '0 2px 8px rgba(0,0,0,0.05)',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '16px'
                  }}
                >
                  <div style={{
                    background: formData.includeInternational ? 'rgba(255,255,255,0.3)' : 'rgba(168,192,232,0.1)',
                    padding: '12px',
                    borderRadius: '12px',
                    display: 'flex'
                  }}>
                    <Globe size={28} />
                  </div>
                  <div style={{ flex: 1 }}>
                    <div style={{
                      fontWeight: '700',
                      fontSize: '18px',
                      marginBottom: '4px'
                    }}>
                      Include International Brands
                    </div>
                    <div style={{
                      fontSize: '14px',
                      opacity: 0.9
                    }}>
                      Show products from Europe, Asia, and other regions
                    </div>
                  </div>
                  <div style={{
                    width: '24px',
                    height: '24px',
                    borderRadius: '50%',
                    background: formData.includeInternational ? 'white' : 'transparent',
                    border: formData.includeInternational ? 'none' : '2px solid rgba(168,192,232,0.5)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center'
                  }}>
                    {formData.includeInternational && (
                      <div style={{
                        width: '10px',
                        height: '10px',
                        background: '#a8c0e8',
                        borderRadius: '50%'
                      }} />
                    )}
                  </div>
                </button>
              </div>

              <div style={{
                display: 'flex',
                gap: '12px'
              }}>
                <button
                  onClick={() => setStep(2)}
                  style={{
                    flex: 1,
                    padding: '18px',
                    background: 'white',
                    color: '#8b7d7d',
                    border: '2px solid rgba(255,159,184,0.3)',
                    borderRadius: '16px',
                    fontSize: '16px',
                    fontWeight: '700',
                    cursor: 'pointer',
                    transition: 'all 0.3s ease'
                  }}
                >
                  Back
                </button>
                <button
                  onClick={handleSubmit}
                  style={{
                    flex: 2,
                    padding: '18px',
                    background: 'linear-gradient(135deg, #ff9fb8, #ffb6c1)',
                    color: 'white',
                    border: 'none',
                    borderRadius: '16px',
                    fontSize: '16px',
                    fontWeight: '700',
                    cursor: 'pointer',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    gap: '10px',
                    boxShadow: '0 8px 24px rgba(255,159,184,0.4)',
                    transition: 'all 0.3s ease'
                  }}
                >
                  <Sparkles size={20} />
                  Get Recommendations
                </button>
              </div>
            </div>
          )}

          {/* Step 4: Results */}
          {step === 4 && recommendations && (
            <div style={{ animation: 'fadeIn 0.5s ease-out' }}>
              <div style={{
                textAlign: 'center',
                marginBottom: '40px'
              }}>
                <div style={{
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: '12px',
                  marginBottom: '15px'
                }}>
                  <Sparkles style={{ color: '#ff9fb8' }} size={32} />
                  <h2 style={{
                    margin: 0,
                    fontSize: '32px',
                    color: '#6b5b5b',
                    fontWeight: '700'
                  }}>
                    Your Personalized Recommendations
                  </h2>
                </div>
                <p style={{
                  color: '#8b7d7d',
                  fontSize: '15px',
                  margin: 0
                }}>
                  Based on your baby's needs, here are our top picks
                </p>
              </div>

              <div style={{
                display: 'flex',
                flexDirection: 'column',
                gap: '20px',
                marginBottom: '30px'
              }}>
                {recommendations.map((product, index) => (
                  <div
                    key={product.key}
                    style={{
                      background: index === 0 
                        ? 'linear-gradient(135deg, rgba(255,159,184,0.1), rgba(255,180,193,0.15))'
                        : 'white',
                      padding: '28px',
                      borderRadius: '24px',
                      border: index === 0 
                        ? '2px solid rgba(255,159,184,0.4)' 
                        : '1px solid rgba(255,159,184,0.2)',
                      boxShadow: index === 0 
                        ? '0 12px 32px rgba(255,159,184,0.2)' 
                        : '0 4px 12px rgba(0,0,0,0.05)',
                      position: 'relative',
                      transition: 'all 0.3s ease',
                      animation: `slideInUp 0.5s ease-out ${index * 0.1}s backwards`
                    }}
                  >
                    {index === 0 && (
                      <div style={{
                        position: 'absolute',
                        top: '-12px',
                        right: '24px',
                        background: 'linear-gradient(135deg, #ffd700, #ffed4e)',
                        color: '#8b6914',
                        padding: '6px 16px',
                        borderRadius: '20px',
                        fontSize: '12px',
                        fontWeight: '700',
                        boxShadow: '0 4px 12px rgba(255,215,0,0.3)',
                        letterSpacing: '0.5px'
                      }}>
                        ⭐ TOP MATCH
                      </div>
                    )}

                    <div style={{
                      display: 'flex',
                      justifyContent: 'space-between',
                      alignItems: 'flex-start',
                      marginBottom: '16px',
                      flexWrap: 'wrap',
                      gap: '12px'
                    }}>
                      <div style={{ flex: 1 }}>
                        <h3 style={{
                          margin: '0 0 8px 0',
                          fontSize: '22px',
                          color: '#6b5b5b',
                          fontWeight: '700'
                        }}>
                          {product.name}
                        </h3>
                        <div style={{
                          display: 'flex',
                          gap: '10px',
                          flexWrap: 'wrap',
                          marginBottom: '8px'
                        }}>
                          <span style={{
                            background: 'rgba(168,192,232,0.15)',
                            color: '#5a7ba8',
                            padding: '4px 12px',
                            borderRadius: '12px',
                            fontSize: '12px',
                            fontWeight: '600',
                            display: 'flex',
                            alignItems: 'center',
                            gap: '6px'
                          }}>
                            <Globe size={14} />
                            {product.region}
                          </span>
                          {product.organic && (
                            <span style={{
                              background: 'rgba(152,216,200,0.15)',
                              color: '#4a9b85',
                              padding: '4px 12px',
                              borderRadius: '12px',
                              fontSize: '12px',
                              fontWeight: '600',
                              display: 'flex',
                              alignItems: 'center',
                              gap: '6px'
                            }}>
                              <Leaf size={14} />
                              Organic
                            </span>
                          )}
                          <span style={{
                            background: 'rgba(255,159,184,0.15)',
                            color: '#d47792',
                            padding: '4px 12px',
                            borderRadius: '12px',
                            fontSize: '12px',
                            fontWeight: '600'
                          }}>
                            {product.price}
                          </span>
                        </div>
                      </div>
                      <div style={{
                        background: 'linear-gradient(135deg, #ff9fb8, #ffb6c1)',
                        color: 'white',
                        padding: '8px 16px',
                        borderRadius: '16px',
                        fontSize: '18px',
                        fontWeight: '700',
                        minWidth: '60px',
                        textAlign: 'center',
                        boxShadow: '0 4px 12px rgba(255,159,184,0.3)'
                      }}>
                        {product.score}%
                      </div>
                    </div>

                    <div style={{
                      background: 'rgba(255,255,255,0.6)',
                      padding: '16px',
                      borderRadius: '16px',
                      marginBottom: '16px'
                    }}>
                      <div style={{
                        fontSize: '13px',
                        fontWeight: '600',
                        color: '#8b7d7d',
                        marginBottom: '8px'
                      }}>
                        Key Ingredients
                      </div>
                      <div style={{
                        fontSize: '14px',
                        color: '#6b5b5b',
                        lineHeight: '1.6'
                      }}>
                        {product.ingredients}
                      </div>
                    </div>

                    <div style={{
                      background: 'rgba(152,216,200,0.1)',
                      padding: '16px',
                      borderRadius: '16px',
                      marginBottom: '16px'
                    }}>
                      <div style={{
                        fontSize: '13px',
                        fontWeight: '600',
                        color: '#8b7d7d',
                        marginBottom: '8px'
                      }}>
                        Why We Recommend This
                      </div>
                      <div style={{
                        fontSize: '14px',
                        color: '#6b5b5b',
                        lineHeight: '1.6'
                      }}>
                        {product.why}
                      </div>
                    </div>

                    <div style={{
                      display: 'flex',
                      flexWrap: 'wrap',
                      gap: '8px'
                    }}>
                      <div style={{
                        fontSize: '12px',
                        fontWeight: '600',
                        color: '#8b7d7d',
                        width: '100%',
                        marginBottom: '4px'
                      }}>
                        Free From:
                      </div>
                      {product.avoids.map(avoid => (
                        <span
                          key={avoid}
                          style={{
                            background: 'white',
                            color: '#8b7d7d',
                            padding: '6px 12px',
                            borderRadius: '12px',
                            fontSize: '12px',
                            fontWeight: '600',
                            border: '1px solid rgba(255,159,184,0.2)'
                          }}
                        >
                          {avoid}
                        </span>
                      ))}
                    </div>
                  </div>
                ))}
              </div>

              <div style={{
                background: 'rgba(255,235,245,0.4)',
                padding: '20px',
                borderRadius: '20px',
                marginBottom: '25px',
                border: '1px solid rgba(255,159,184,0.2)'
              }}>
                <div style={{
                  display: 'flex',
                  gap: '12px',
                  alignItems: 'flex-start'
                }}>
                  <AlertCircle style={{ color: '#ff9fb8', flexShrink: 0 }} size={20} />
                  <div>
                    <div style={{
                      fontWeight: '700',
                      color: '#8b7d7d',
                      marginBottom: '6px',
                      fontSize: '14px'
                    }}>
                      Important Note
                    </div>
                    <div style={{
                      fontSize: '13px',
                      color: '#8b7d7d',
                      lineHeight: '1.6'
                    }}>
                      These recommendations are suggestions based on your inputs. Always patch test new products and consult your pediatrician, especially for babies with existing skin conditions or severe allergies.
                    </div>
                  </div>
                </div>
              </div>

              <button
                onClick={resetForm}
                style={{
                  width: '100%',
                  padding: '18px',
                  background: 'linear-gradient(135deg, #ff9fb8, #ffb6c1)',
                  color: 'white',
                  border: 'none',
                  borderRadius: '16px',
                  fontSize: '16px',
                  fontWeight: '700',
                  cursor: 'pointer',
                  boxShadow: '0 8px 24px rgba(255,159,184,0.4)',
                  transition: 'all 0.3s ease'
                }}
              >
                Start New Search
              </button>
            </div>
          )}
        </div>

        {/* Footer */}
        <div style={{
          textAlign: 'center',
          marginTop: '40px',
          color: '#8b7d7d',
          fontSize: '13px',
          opacity: 0.8
        }}>
          Made with <Heart size={14} style={{ display: 'inline', color: '#ff9fb8', verticalAlign: 'middle' }} /> for healthy baby skin
        </div>
      </div>

      <style>{`
        @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&family=Quicksand:wght@400;600;700&display=swap');
        
        @keyframes fadeInDown {
          from {
            opacity: 0;
            transform: translateY(-20px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }
        
        @keyframes fadeInUp {
          from {
            opacity: 0;
            transform: translateY(20px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }
        
        @keyframes fadeIn {
          from {
            opacity: 0;
          }
          to {
            opacity: 1;
          }
        }
        
        @keyframes slideInUp {
          from {
            opacity: 0;
            transform: translateY(30px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }
        
        button:hover:not(:disabled) {
          transform: translateY(-2px);
          box-shadow: 0 12px 32px rgba(255,159,184,0.35) !important;
        }
        
        button:active:not(:disabled) {
          transform: translateY(0);
        }
        
        select:focus {
          outline: none;
          border-color: #ff9fb8;
          box-shadow: 0 0 0 3px rgba(255,159,184,0.2);
        }
      `}</style>
    </div>
  );
};

export default BabySkincareApp;

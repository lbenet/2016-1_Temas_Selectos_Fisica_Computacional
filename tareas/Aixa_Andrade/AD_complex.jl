module AD_complex
# Define el tipo (estructura) `Dual` (**con exactamente ese nombre**) que #contenga dos campos, el valor de la función y el valor de su derivada. #Haz que *ambos* campos tengan el mismo tipo de valor, y que ambos #*tengan* que ser un subtipo de `Real`.

export Dual
export Dual_var

type Dual{T<:Number}  
    x :: T
    y :: T
end 

Dual(a,b) = Dual(promote(a,b)...)

#Define métodos para que el dual de un número (sólo *un* número) sea lo #que uno espera, y una función `dual_var(x0)` que retorne un dual que #represente a la variable *independiente* en `x0`.

Dual(x) = Dual(x,0)

Dual_var(x0)=Dual(x0,1) 


# Define métodos que sumen, resten, multipliquen y dividan duales, y #números con duales. Incluye los casos (para duales) en que los #operadores `+` y `-` actúan sólo sobre un `Dual`.



import Base.+
+(a::Dual, b::Dual) = Dual( a.x + b.x, a.y + b.y )
+(a::Dual, b::Real) = Dual( a.x + b, a.y)
+(b::Real, a::Dual) = Dual( a.x + b, a.y)
+(a::Dual, b::Complex) = Dual( a.x + b, a.y)
+(b::Complex, a::Dual) = Dual( a.x + b, a.y)
+(a::Dual) = Dual(+a.x,+a.y)

import Base.abs
abs(a::Dual)=Dual(abs(a.x),a.y * sign(a.x)/sign(-a.x))


import Base.-
-(a::Dual, b::Dual) = Dual( a.x - b.x, a.y - b.y ) 
-(a::Dual, b::Real) = Dual( a.x - b, a.y)
-(b::Real, a::Dual) = Dual( a.x - b, a.y)
-(a::Dual, b::Complex) = Dual( a.x - b, a.y)
-(b::Complex, a::Dual) = Dual( a.x - b, a.y)
-(a::Dual) = Dual(-a.x,-a.y)

import Base.*

*(a::Dual,b::Dual)=Dual(a.x*b.x,a.y*b.x+a.x*b.y)
*(a::Real,b::Dual)=Dual(a*b.x,a*b.y)
*(b::Dual,a::Real)=a*b
*(a::Complex,b::Dual)=Dual(a*b.x,a*b.y)
*(b::Dual,a::Complex)=a*b

import Base./
/(a::Dual,b::Dual)=Dual(a.x/b.x,(b.x*a.y-a.x*b.y)/(b.x^2))
/(a::Dual,b::Real) = a/Dual(b)
/(b::Real,a::Dual) =Dual(b)/a
/(a::Dual,b::Complex) = a/Dual(b)
/(b::Complex,a::Dual) =Dual(b)/a

import Base.^
^(b::Dual,a :: Real)=Dual(b.x^a,a*b.y*b.x^(a-1))
^(b::Dual,a :: Integer)=Dual(b.x^a,a*b.y*b.x^(a-1))
^(b::Dual,a :: Complex)=Dual(b.x^a,a*b.y*b.x^(a-1))
^(a::Dual, b::Dual) = DualC( a.x ^b.x, b.x * a.x^(b.x-1) * a.y)

import Base.exp
exp(b::Dual)=Dual(exp(b.x),b.y*exp(b.x))


import Base.cos
cos(b::Dual)=Dual(cos(b.x),-b.y*sin(b.x))

import Base.sin

sin(b::Dual)=Dual(sin(b.x),b.y*cos(b.x))

import Base.tan
tan(a::Dual)=Dual(tan(a.x),sec(a.x)^2 * a.y)

import Base.cot
cot(a::Dual)=Dual(cot(a.x),-csc(a.x)^2 * a.y)

import Base.sec
sec(a::Dual)=Dual(sec(a.x),sec(a.x)*tan(a.x)*a.y)

import Base.csc
csc(a::Dual)=Dual(csc(a.x),-csc(a.x)*cot(a.x)*a.y)

import Base.asin
asin(a::Dual)=Dual(asin(a.x),a.y/sqrt(1-a.x^2))

import Base.acos
acos(a::Dual)=Dual(acos(a.x),-a.y/sqrt(1-a.x^2))

import Base.atan
atan(a::Dual)=Dual(atan(a.x),a.y/(a.x^2+1))

import Base.acot
acot(a::Dual)=Dual(acot(a.x),-a.y/(1+a.x^2))

import Base.asec
asec(a::Dual)=Dual(asec(a.x),a.y/(abs(a.x)*sqrt(a.x^2-1)))

import Base.acsc
acsc(a::Dual)=Dual(acsc(a.x),-a.y/(abs(a.x)*sqrt(a.x^2-1)))



end



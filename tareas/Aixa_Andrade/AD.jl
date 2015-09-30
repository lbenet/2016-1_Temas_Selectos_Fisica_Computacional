module AD
# Define el tipo (estructura) `Dual` (**con exactamente ese nombre**) que #contenga dos campos, el valor de la función y el valor de su derivada. #Haz que *ambos* campos tengan el mismo tipo de valor, y que ambos #*tengan* que ser un subtipo de `Real`.

export dual
export dual_var

type dual
    f ::Real
    d_f:: Real
end

dual(a,b) = dual(promote(a,b)...)

#Define métodos para que el dual de un número (sólo *un* número) sea lo #que uno espera, y una función `dual_var(x0)` que retorne un dual que #represente a la variable *independiente* en `x0`.

dual(x) = dual(x,0)

dual_var(x0)=dual(x0,1) 


# Define métodos que sumen, resten, multipliquen y dividan duales, y #números con duales. Incluye los casos (para duales) en que los #operadores `+` y `-` actúan sólo sobre un `Dual`.

import Base.+

+(a::dual,b::dual)=dual(a.f+b.f,a.d_f+b.d_f)
+(a::dual,b::Real) = a + dual(b)
+(b::Real,a::dual) = a + b
+(a::dual)=a.f+a.df

import Base.-

-(a::dual,b::dual) = dual(a.f-b.f,a.d_f-b.d_f)
-(a::dual,b::Real) = a - dual(b)
-(b::Real,a::dual) = a - b
-(a::dual)=a.f-a.d_f

import Base.*

*(a::dual,b::dual)=dual(a.f*b.f,a.d_f*b.f+a.f*b.d_f)
*(a::dual,b::Real) = a*dual(b)
*(b::Real,a::dual) = a*b
*(a::Real,b::dual)=dual(a*b.f,a*b.d_f)
*(b::dual,a::Real)=a*b

import Base./
/(a::dual,b::dual)=dual(a.f/b.f,(b.f*a.d_f-a.f*b.d_f)/(b.f^2))
/(a::dual,b::Real) = a/dual(b)
/(b::Real,a::dual) =dual(b)/a

import Base.^
^(b::dual,a :: Real)=dual(b.f^a,a*b.d_f*b.f^(a-1))

import Base.exp
exp(b::dual)=dual(exp(b.f),b.d_f*exp(b.f))

import Base.cos
cos(b::dual)=dual(cos(b.f),-b.d_f*sin(b.f))

import Base.sin
sin(b::dual)=dual(sin(b.f),b.d_f*cos(b.f))

-(a::dual) = dual(-a.f,-a.d_f)







end


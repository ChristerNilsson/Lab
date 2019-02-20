ALFA = 'ABCDEFHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
caesar = (s,n) -> (ALFA[(n + ALFA.indexOf ch) %% ALFA.length] for ch in s).join ''

assert 'Disjtufs', caesar 'Christer',+1
assert 'Christer', caesar 'Disjtufs',-1

assert 'zeofpqbo', caesar 'Christer',-3
assert 'Christer', caesar 'zeofpqbo',+3

### 48 loc in Java:

public class CaesarCipher {
	public static String encrypt(String plainText, char charKey) {
    StringBuilder cipherText = new StringBuilder();
    int intKey;
    if (Character.isUpperCase(charKey)) {
    	intKey = charKey - 65;
			} else {
      intKey = charKey - 97;
    }
    
    for (int i = 0; i < plainText.length(); i++) {
      char letter = plainText.charAt(i);
      int intLetter = (int) letter;
      char cipherLetter;
      if (Character.isUpperCase(letter)) {
        cipherLetter = (char)(65+((intLetter-65+intKey)%26));
      } else {
        cipherLetter = (char)(97+((intLetter-97+intKey)%26));
      }
      cipherText.append(cipherLetter);
    }
    return cipherText.toString();
	}

  public static String decrypt(String cipherText, char charKey) {
    StringBuilder plainText = new StringBuilder();
    int intKey;
    if (Character.isUpperCase(charKey)) {
      intKey = charKey - 65;
    } else {
      intKey = charKey - 97;
    }
    
    for (int i = 0; i < cipherText.length(); i++) {
      char letter = cipherText.charAt(i);
      int intLetter = (int) letter;
      char plainLetter;

      if(Character.isUpperCase(letter)) {
        plainLetter = (char)(65+((intLetter-65)-intKey));
      } else {
        plainLetter = (char)(97+((intLetter-97)-intKey));
      }
      plainText.append(plainLetter);
    }
    return plainText.toString();
  }
}
###

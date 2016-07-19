import pygame

pygame.init()


windowSurface = pygame.display.set_mode((1000, 750), pygame.DOUBLEBUF)

done = False

while not done:
    # --- Main event loop
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            done = True

    s = pygame.Surface((1000,750), pygame.SRCALPHA)   # per-pixel alpha
    s.fill((255,255,255,128))                         # notice the alpha value in the color
    pygame.draw.circle(s, pygame.Color(255, 0, 0, 128), (100, 100), 100)
    pygame.draw.circle(windowSurface, pygame.Color(0, 255, 0, 128), (150, 100), 100)
    windowSurface.blit(s, (0,0), pygame.BLEND_RGBA_ADD)

    s.fill((255,255,255))

    pygame.display.flip()
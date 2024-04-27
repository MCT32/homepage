<div class="container">
    <div class="cube">
        <div class="face front" />
        <div class="face back" />
        <div class="face left" />
        <div class="face right" />
        <div class="face top" />
        <div class="face bottom" />
    </div>
</div>


<style lang="postcss">
    @keyframes turn {
        from { transform: rotate3d(0, 0, 0, 0); }
        to { transform: rotate3d(1, 2, 0, 360deg); }
    }

    @media (prefers-reduced-motion: reduce) {
        .cube {
            animation: none;
            transform: rotate3d(1, 1, 0, 45deg);
        }
    }

    .container {
        width: 25rem;
        height: 25rem;
        margin: 12.5rem;
        perspective: 50rem;
    }

    .cube {
        position: relative;
        width: 25rem;
        height: 25rem;
        transform-style: preserve-3d;
        animation: turn 5s linear infinite;
    }

    .face {
        width: 25rem;
        height: 25rem;
        border: 2px solid theme("colors.green.600");
        position: absolute;
    }

    .front {
        transform: translateZ(12.5rem);
    }

    .back {
        transform: translateZ(-12.5rem);
    }

    .left {
        transform: translateX(-12.5rem) rotateY(90deg);
    }

    .right {
        transform: translateX(12.5rem) rotateY(90deg);
    }

    .top {
        transform: translateY(-12.5rem) rotateX(90deg);
    }

    .bottom {
        transform: translateY(12.5rem) rotateX(90deg);
    }
</style>

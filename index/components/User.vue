

<template>
    <div class="flex items-center w-200px flex-col p-5 pb-0">
        <img class="w-100px h-100px rounded-1/2 border-gray-500 border-3 " :src="props.src"/>
        <p class="text-center w-max mb-0">{{props.name}} @ {{props.school}}</p>
    </div>
</template>

<script setup>

const props = defineProps({
    src: {
        type: String,
        default: '',
    },
    name: {
        type: String,
        default: '',
    },
    school: {
        type: String,
        default: '',
    },
});


</script>